//
//  CSCI494FlipsideViewController.m
//  Flipside Test
//
//  Created by Andrew Wilson on 1/29/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import "CSCI494FlipsideViewController.h"

@interface CSCI494FlipsideViewController ()
@end

@implementation CSCI494FlipsideViewController

- (void)awakeFromNib
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
    [super awakeFromNib];
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



#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)Red:(id)sender {
    CGRect frame = CGRectMake(60, 100, 200, 200);
    subView = [[UIView alloc] initWithFrame:frame];
    subView.backgroundColor = [UIColor redColor];
    [self addSubview:subView];
}

- (IBAction)Blue:(id)sender {
    CGRect frame = CGRectMake(60, 100, 200, 200);
    subView = [[UIView alloc] initWithFrame:frame];
    subView.backgroundColor = [UIColor blueColor];
    [self addSubview:subView];
}

- (IBAction)Green:(id)sender {
    CGRect frame = CGRectMake(60, 100, 200, 200);
    subView = [[UIView alloc] initWithFrame:frame];
    subView.backgroundColor = [UIColor greenColor];
    [self addSubview:subView];
}

- (IBAction)Draw:(id)sender {
    UIBezierPath *myPath=[[UIBezierPath alloc]init];
    myPath.lineWidth=10;
//    brushPattern=[UIColor redColor]; //This is the color of my stroke
}
   @end
