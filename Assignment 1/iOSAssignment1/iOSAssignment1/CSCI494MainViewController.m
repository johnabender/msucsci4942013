//
//  CSCI494MainViewController.m
//  iOSAssignment1
//
//  Created by Andrew Wilson on 1/28/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import "CSCI494MainViewController.h"

@interface CSCI494MainViewController ()

@end

@implementation CSCI494MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(CSCI494FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
