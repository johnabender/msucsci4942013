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
}
@end


@implementation TDView

-(void) awakeFromNib
{
    self.backgroundColor = [UIColor blackColor];

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


#pragma mark - Touches

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    movingTouch = [touches anyObject];

    CGPoint touchPoint = [movingTouch locationInView:self];
    UIView *v = [self hitTest:touchPoint withEvent:event];
    if( v != self ) {
        movingView = v;
        touchOffset = CGSizeMake( v.center.x - touchPoint.x, v.center.y - touchPoint.y );
        originalPosition = movingView.center;
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
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches containsObject:movingTouch] ) {
        CGPoint touchPoint = [movingTouch locationInView:self];
        movingView.center = CGPointMake( touchPoint.x + touchOffset.width, touchPoint.y + touchOffset.height );
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches containsObject:movingTouch] ) {
        [UIView animateWithDuration:0.3 animations:^{
            movingView.alpha = 1.;
            movingView.transform = CGAffineTransformIdentity;
        }];

        CABasicAnimation *a = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        a.duration = 0.3;
        a.toValue = @0.;
        a.delegate = self;
        [movingView.layer addAnimation:a forKey:animationKey];
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

@end
