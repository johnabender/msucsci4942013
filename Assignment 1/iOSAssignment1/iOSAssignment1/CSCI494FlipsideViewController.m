//
//  CSCI494FlipsideViewController.m
//  iOSAssignment1
//
//  Created by Andrew Wilson on 1/28/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import "CSCI494FlipsideViewController.h"

@interface CSCI494FlipsideViewController ()

@end

@implementation CSCI494FlipsideViewController

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

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
