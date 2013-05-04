-//
2    	
-//  CSCI494MainViewController.m
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
-#import "CSCI494MainViewController.h"
10	  	
-
11	  	
-@interface CSCI494MainViewController ()
12	  	
-
13	  	
-@end
14	  	
-
15	  	
-@implementation CSCI494MainViewController
16	  	
-
17	  	
-- (void)viewDidLoad
18	  	
-{
19	  	
-    [super viewDidLoad];
20	  	
-  // Do any additional setup after loading the view, typically from a nib.
21	  	
-}
22	  	
-
23	  	
-- (void)didReceiveMemoryWarning
24	  	
-{
25	  	
-    [super didReceiveMemoryWarning];
26	  	
-    // Dispose of any resources that can be recreated.
27	  	
-}
28	  	
-
29	  	
-#pragma mark - Flipside View
30	  	
-
31	  	
-- (void)flipsideViewControllerDidFinish:(CSCI494FlipsideViewController *)controller
32	  	
-{
33	  	
-    [self dismissViewControllerAnimated:YES completion:nil];
34	  	
-}
35	  	
-
36	  	
-- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
37	  	
-{
38	  	
-    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
39	  	
-        [[segue destinationViewController] setDelegate:self];
40	  	
-    }
41	  	
-}
42	  	
-
43	  	
-@end
