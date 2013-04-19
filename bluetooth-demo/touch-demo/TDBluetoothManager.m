//
//  TDBluetoothManager.m
//  touch-demo
//
//  Created by John Bender on 4/18/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "TDBluetoothManager.h"

@implementation TDBluetoothManager

static TDBluetoothManager *sharedInstance = nil;

+(TDBluetoothManager*) instance
{
    if( sharedInstance == nil )
        sharedInstance = [TDBluetoothManager new];
    return sharedInstance;
}

-(id) init
{
    self = [super init];
    if( self ) {
        session = [[GKSession alloc] initWithSessionID:@"msudemochatclientsessionid"
                                           displayName:[[UIDevice currentDevice] name]
                                           sessionMode:GKSessionModePeer];
        session.delegate = self;
        _peerName = nil;

        connectionPicker = [GKPeerPickerController new];
        connectionPicker.delegate = self;
        connectionPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
        [connectionPicker show];
    }
    return self;
}


+(BOOL) hasConnection
{
    return (sharedInstance != nil && sharedInstance.peerName != nil);
}


-(void) sendDictionaryToPeers:(NSDictionary*)dict
{
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [session sendDataToAllPeers:encodedData withDataMode:GKSendDataUnreliable error:nil];
}

-(void) receiveData:(NSData*)data
           fromPeer:(NSString*)peer
          inSession:(GKSession*)theSession
            context:(void*)context
{
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    NSInteger command = [dict[@"command"] intValue];

    switch( command )
    {
        case msuBluetoothCommandHandshake:
        {
            _peerName = [dict objectForKey:@"peerName"];

            // start negotiating player index
            playerIndexTimestamp = [NSDate date];
            NSDictionary *negotiation = @{@"command":     @(msuBluetoothCommandNegotiate),
                                          @"playerIndex": @0,
                                          @"timestamp":   playerIndexTimestamp};
            [self sendDictionaryToPeers:negotiation];
            break;
        }
        case msuBluetoothCommandNegotiate:
        {
            NSDate *otherTimestamp = [dict objectForKey:@"timestamp"];
            NSInteger otherPlayer = [[dict objectForKey:@"playerIndex"] intValue];

            if( [otherTimestamp compare:playerIndexTimestamp] == NSOrderedAscending )
            {
                // other timestamp was earlier, so it wins
                _playerIndex = 1 - otherPlayer;
                NSDictionary *negotiation = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:msuBluetoothCommandNegotiateConfirm], @"command",
                                             [NSNumber numberWithInt:_playerIndex], @"playerIndex",
                                             nil];
                [self sendDictionaryToPeers:negotiation];

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Player Index"
                                                                message:[NSString stringWithFormat:@"Other timestamp won, setting my index to %i", _playerIndex]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            break;
        }
        case msuBluetoothCommandNegotiateConfirm:
        {
            NSInteger otherPlayer = [[dict objectForKey:@"playerIndex"] intValue];
            _playerIndex = 1 - otherPlayer;

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Player Index"
                                                            message:[NSString stringWithFormat:@"Peer confirmed my timestamp won, setting my index to %i", _playerIndex]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            break;
        }
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"bluetoothDataReceived" object:dict];
}


#pragma  mark - Peer picker delegate

-(GKSession*) peerPickerController:(GKPeerPickerController*)picker
          sessionForConnectionType:(GKPeerPickerConnectionType)type
{
    return session;
}


-(void) peerPickerController:(GKPeerPickerController*)picker
              didConnectPeer:(NSString*)newPeer
                   toSession:(GKSession*)session
{
    [picker dismiss];
}


-(void) peerPickerControllerDidCancel:(GKPeerPickerController*)picker
{
}


#pragma mark - Session delegate

-(void) session:(GKSession*)theSession
           peer:(NSString*)thePeer
 didChangeState:(GKPeerConnectionState)state
{
    if( state == GKPeerStateConnected )
    {
        peerId = thePeer;
        [session setDataReceiveHandler:self withContext:nil];

        NSDictionary *handshake = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @(msuBluetoothCommandHandshake), @"command",
                                   [[UIDevice currentDevice] name], @"peerName",
                                   nil];
        [self sendDictionaryToPeers:handshake];
    }
    else if( state == GKPeerStateDisconnected )
    {
    }
}

@end
