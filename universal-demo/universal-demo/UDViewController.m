//
//  UDViewController.m
//  universal-demo
//
//  Created by John Bender on 3/22/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "UDViewController.h"

@interface UDViewController ()
{
    __weak IBOutlet UIImageView *imageView;
}

@end

@implementation UDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    imageView.image = [UIImage imageNamed:@"red"];

    UIInterfaceOrientation o = [[UIApplication sharedApplication] statusBarOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
