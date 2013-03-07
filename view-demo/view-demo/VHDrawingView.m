//
//  VHDrawingView.m
//  view-demo
//
//  Created by John Bender on 1/25/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "VHDrawingView.h"

@implementation VHDrawingView

/* this is commented out because it's not needed in this project...
 actually, the better thing would be to have an initialization function that's
 called both by initWithFrame and by awakeFromNib, so the same initialization code
 gets executed no matter whether the view is instantiated in code or from IB

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 */

// try changing this from 0 to 1 to draw either a rounded rectangle or a diagonal line
#define DRAW_LINE 0

-(void) awakeFromNib
{
    self.backgroundColor = [UIColor blackColor];

    // here's why it didn't work to do the drawing in this function...
    NSLog( @"size is %@", NSStringFromCGRect( self.bounds ) );
    // ...the size of this view hasn't been set yet, so the path draws from (0,0) to (0,0)

    // the fix is this -- note the block syntax!
    // we run the following block of code on the main thread, on the next run loop
    dispatch_async( dispatch_get_main_queue(), ^{
#if DRAW_LINE
        path = [UIBezierPath new];
        [path moveToPoint:CGPointMake( 0., 0. )];
        [path addLineToPoint:CGPointMake( self.bounds.size.width, self.bounds.size.height )];

#else
        path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:15.];

#endif

        path.lineWidth = 5.;

        // now we have to notify the OS that this view needs to be redrawn
        [self setNeedsDisplay];
    });
}


- (void)drawRect:(CGRect)rect
{
    // note this gets called twice a few milliseconds apart, once when the view is
    // awakened, and a second time as a result of the redraw request we made above
    NSLog( @"drawing %@", path );

    [[UIColor redColor] set];
#if DRAW_LINE
    [path stroke];
#else
    [path fill];
#endif
}

@end
