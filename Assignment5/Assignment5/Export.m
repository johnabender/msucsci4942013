//
//  Export.m
//  Assignment5
//
//  Created by Andrew Wilson on 4/24/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import "Export.h"

@interface Export ()

@end

@implementation Export

@synthesize button;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    CGRect frame = CGRectMake(20, 10, 280, 50);
    //---create a button view---
    frame= CGRectMake(20, 60, 280, 50);
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    
    //---add the action handler and set the currnt class as target---
    [button addTarget:self
               action:@selector(buttonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //---add the views to the view window---
    [self.view addSubview:button];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
