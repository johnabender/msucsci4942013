//
//  CSCI494ViewController.m
//  iOS Assignment 1
//
//  Created by Andrew Wilson on 1/28/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

// good job, 100%

#import "CSCI494ViewController.h"

@interface CSCI494ViewController ()

@end

@implementation CSCI494ViewController

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

- (IBAction)wonderfulbutton:(id)sender {
    
    NSString *wonderful = [[NSString alloc] initWithFormat:@"WONDERFUL!!!!!!"];
  self.label.text = wonderful;
}
@end
