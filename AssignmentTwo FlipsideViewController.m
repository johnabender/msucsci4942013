-//
2    	
-//  CSCI494FlipsideViewController.m
3	  	
-//  Flipside Test
4	  	
-//
5	  	
-//  Created by Andrew Wilson on 1/29/13.
6	  	
-//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
7	  	
-//
8	  	
-
9	  	
-#import "CSCI494FlipsideViewController.h"
10	  	
-
11	  	
-@interface CSCI494FlipsideViewController ()
12	  	
-@end
13	  	
-
14	  	
-@implementation CSCI494FlipsideViewController
15	  	
-
16	  	
-- (void)awakeFromNib
17	  	
-{
18	  	
-    self.backgroundColor = [UIColor blackColor];
19	  	
-    
20	  	
-    // here's why it didn't work to do the drawing in this function...
21	  	
-    NSLog( @"size is %@", NSStringFromCGRect( self.bounds ) );
22	  	
-    // ...the size of this view hasn't been set yet, so the path draws from (0,0) to (0,0)
23	  	
-    
24	  	
-    // the fix is this -- note the block syntax!
25	  	
-    // we run the following block of code on the main thread, on the next run loop
26	  	
-    dispatch_async( dispatch_get_main_queue(), ^{
27	  	
-#if DRAW_LINE
28	  	
-        path = [UIBezierPath new];
29	  	
-        [path moveToPoint:CGPointMake( 0., 0. )];
30	  	
-        [path addLineToPoint:CGPointMake( self.bounds.size.width, self.bounds.size.height )];
31	  	
-        
32	  	
-#else
33	  	
-        path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:15.];
34	  	
-        
35	  	
-#endif
36	  	
-        
37	  	
-        path.lineWidth = 5.;
38	  	
-        
39	  	
-        // now we have to notify the OS that this view needs to be redrawn
40	  	
-        [self setNeedsDisplay];
41	  	
-    });
42	  	
-    [super awakeFromNib];
43	  	
-}
44	  	
-
45	  	
-- (void)drawRect:(CGRect)rect
46	  	
-{
47	  	
-    // note this gets called twice a few milliseconds apart, once when the view is
48	  	
-    // awakened, and a second time as a result of the redraw request we made above
49	  	
-    NSLog( @"drawing %@", path );
50	  	
-    
51	  	
-    [[UIColor redColor] set];
52	  	
-#if DRAW_LINE
53	  	
-    [path stroke];
54	  	
-#else
55	  	
-    [path fill];
56	  	
-#endif
57	  	
-}
58	  	
-
59	  	
-
60	  	
-
61	  	
-#pragma mark - Actions
62	  	
-
63	  	
-- (IBAction)done:(id)sender
64	  	
-{
65	  	
-    [self.delegate flipsideViewControllerDidFinish:self];
66	  	
-}
67	  	
-
68	  	
-- (IBAction)Red:(id)sender {
69	  	
-    CGRect frame = CGRectMake(60, 100, 200, 200);
70	  	
-    subView = [[UIView alloc] initWithFrame:frame];
71	  	
-    subView.backgroundColor = [UIColor redColor];
72	  	
-    [self addSubview:subView];
73	  	
-}
74	  	
-
75	  	
-- (IBAction)Blue:(id)sender {
76	  	
-    CGRect frame = CGRectMake(60, 100, 200, 200);
77	  	
-    subView = [[UIView alloc] initWithFrame:frame];
78	  	
-    subView.backgroundColor = [UIColor blueColor];
79	  	
-    [self addSubview:subView];
80	  	
-}
81	  	
-
82	  	
-- (IBAction)Green:(id)sender {
83	  	
-    CGRect frame = CGRectMake(60, 100, 200, 200);
84	  	
-    subView = [[UIView alloc] initWithFrame:frame];
85	  	
-    subView.backgroundColor = [UIColor greenColor];
86	  	
-    [self addSubview:subView];
87	  	
-}
88	  	
-
89	  	
-- (IBAction)Draw:(id)sender {
90	  	
-    UIBezierPath *myPath=[[UIBezierPath alloc]init];
91	  	
-    myPath.lineWidth=10;
92	  	
-//    brushPattern=[UIColor redColor]; //This is the color of my stroke
93	  	
-}
94	  	
-   @end
