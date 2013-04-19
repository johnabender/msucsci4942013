//
//  TDBluetoothManager.h
//  touch-demo
//
//  Created by John Bender on 4/18/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

typedef enum {
    msuBluetoothCommandHandshake=1,
    msuBluetoothCommandNegotiate,
    msuBluetoothCommandNegotiateConfirm,
    msuBluetoothCommandLayout,
    msuBluetoothCommandMove,
    msuBluetoothCommandDrop
} BluetoothCommand;


@interface TDBluetoothManager : NSObject
<GKSessionDelegate, GKPeerPickerControllerDelegate>
{
    GKSession *session;
    NSString *peerId;

    GKPeerPickerController *connectionPicker;

    NSDate *playerIndexTimestamp;
}

@property (nonatomic, readonly) NSString *peerName;
@property (nonatomic, readonly) NSInteger playerIndex;

+(TDBluetoothManager*) instance;
+(BOOL) hasConnection;

-(void) sendDictionaryToPeers:(NSDictionary*)dict;

@end
