//
//  TDView.m
//  touch-demo
//
//  Created by John Bender on 3/7/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "TDView.h"
#import "UIColor+RandomColor.h"
#import <QuartzCore/QuartzCore.h>
#import "TDBluetoothManager.h"

static const NSInteger nViews = 10;
static const CGFloat viewSize = 100.;
static NSString* const animationKey = @"myCornerRadiusAnimation";

#define RAND_FLOAT ((CGFloat)rand()/(CGFloat)RAND_MAX)


@interface TDView()
{
    CGSize touchOffset;
    UIView *movingView;
    UITouch *movingTouch;
    CGPoint originalPosition;
    NSInteger originalIndex;
}
@end


@implementation TDView

-(void) awakeFromNib
{
    self.backgroundColor = [UIColor blackColor];

    [TDBluetoothManager instance];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(bluetoothDataReceived:)
                                                 name:@"bluetoothDataReceived"
                                               object:nil];
}

-(void) setupViews
{
    for( NSInteger i = 0; i < nViews; i++ ) {
        CGFloat x = RAND_FLOAT*(self.frame.size.width - viewSize);
        CGFloat y = RAND_FLOAT*(self.frame.size.height - viewSize);
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake( x, y, viewSize, viewSize )];
        v.backgroundColor = [UIColor randomColor];
        v.layer.borderColor = [[UIColor whiteColor] CGColor];
        v.layer.borderWidth = 2.;
        [self addSubview:v];
    }
}

-(void) setupFromDictionary:(NSDictionary*)dict
{
    for( int i = 0; i < nViews; i++ )
    {
        CGRect frame;
        frame.origin = [[dict objectForKey:[NSString stringWithFormat:@"view%d", i]] CGPointValue];
        frame.size.width = frame.size.height = viewSize;
        UIView *v = [[UIView alloc] initWithFrame:frame];

        NSString *colorKey = [NSString stringWithFormat:@"color%d", i];
        UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:dict[colorKey]];
        v.backgroundColor = color;

        v.layer.borderColor = [[UIColor whiteColor] CGColor];
        v.layer.borderWidth = 2.;
        [self addSubview:v];
    }
}


#pragma mark - Touches

-(void) pickUpView:(UIView*)v
{
    [self bringSubviewToFront:movingView];

    [UIView animateWithDuration:0.3 animations:^{
        movingView.alpha = 0.85;
        CGAffineTransform t = CGAffineTransformMakeScale( 1.11, 1.11 );
        t = CGAffineTransformRotate( t, M_PI );
        movingView.transform = t;
    }];

    CABasicAnimation *a = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    a.duration = 0.3;
    a.toValue = @50.;
    a.delegate = self;
    [movingView.layer addAnimation:a forKey:animationKey];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( movingView ) return;
    
    movingTouch = [touches anyObject];

    CGPoint touchPoint = [movingTouch locationInView:self];
    UIView *v = [self hitTest:touchPoint withEvent:event];
    if( v != self ) {
        movingView = v;
        touchOffset = CGSizeMake( v.center.x - touchPoint.x, v.center.y - touchPoint.y );
        originalPosition = movingView.center;
        originalIndex = [self.subviews indexOfObject:movingView];
        [self pickUpView:movingView];
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches containsObject:movingTouch] ) {
        CGPoint touchPoint = [movingTouch locationInView:self];
        movingView.center = CGPointMake( touchPoint.x + touchOffset.width, touchPoint.y + touchOffset.height );

        NSDictionary *dict = @{@"command": @(msuBluetoothCommandMove),
                               @"viewNumber": @(originalIndex),
                               @"newCenter": [NSValue valueWithCGPoint:movingView.center]};
        [[TDBluetoothManager instance] sendDictionaryToPeers:dict];
    }
}

-(void) dropView:(UIView*)v
{
    [UIView animateWithDuration:0.3 animations:^{
        movingView.alpha = 1.;
        movingView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        movingView = nil;
    }];

    CABasicAnimation *a = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    a.duration = 0.3;
    a.toValue = @0.;
    a.delegate = self;
    [movingView.layer addAnimation:a forKey:animationKey];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches containsObject:movingTouch] ) {
        [self dropView:movingView];
        movingTouch = nil;

        NSDictionary *dict = @{@"command": @(msuBluetoothCommandDrop)};
        [[TDBluetoothManager instance] sendDictionaryToPeers:dict];
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches containsObject:movingTouch] ) {
        [UIView animateWithDuration:0.3 animations:^{
            movingView.center = originalPosition;
        } completion:^(BOOL finished) {
            [self touchesEnded:touches withEvent:event];
        }];
    }
}


#pragma mark - Animation delegate

-(void) animationDidStart:(CAAnimation *)anim
{
}

-(void) animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    movingView.layer.cornerRadius = [anim.toValue floatValue];
    [movingView.layer removeAnimationForKey:animationKey];
}


#pragma mark - Bluetooth callback

-(void) bluetoothDataReceived:(NSNotification*)note
{
    NSDictionary *dict = [note object];
    NSInteger command = [[dict objectForKey:@"command"] intValue];
    switch( command )
    {
        case msuBluetoothCommandNegotiateConfirm:
        {
            // we won the timestamp race, so we set up the view
            [self setupViews];

            NSMutableDictionary *layout = [NSMutableDictionary dictionary];
            [layout setObject:[NSNumber numberWithInt:msuBluetoothCommandLayout] forKey:@"command"];
            for( int i = 0; i < [self.subviews count]; i++ )
            {
                UIView *subview = [self.subviews objectAtIndex:i];
                NSString *keyName = [NSString stringWithFormat:@"view%d", i];
                [layout setObject:[NSValue valueWithCGPoint:subview.frame.origin] forKey:keyName];
                NSData* colorData = [NSKeyedArchiver archivedDataWithRootObject:subview.backgroundColor];
                [layout setObject:colorData forKey:[NSString stringWithFormat:@"color%d", i]];
            }
            [[TDBluetoothManager instance] sendDictionaryToPeers:layout];
            break;
        }
        case msuBluetoothCommandLayout:
        {
            [self setupFromDictionary:dict];
            break;
        }
        case msuBluetoothCommandMove:
        {
            NSInteger viewNumber = [dict[@"viewNumber"] intValue];
            UIView *v = [self.subviews objectAtIndex:viewNumber];
            if( movingView == nil ) {
                movingView = v;
                [self pickUpView:v];
            }
            CGPoint newCenter = [dict[@"newCenter"] CGPointValue];
            movingView.center = newCenter;
            break;
        }
        case msuBluetoothCommandDrop:
        {
            [self dropView:movingView];
            break;
        }
    }
}

@end
