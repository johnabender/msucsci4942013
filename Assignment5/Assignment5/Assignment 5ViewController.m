//
//  Assignment 5ViewController.m
//  Assignment5
//
//  Created by Andrew Wilson on 4/23/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import "Assignment 5ViewController.h"

@interface Assignment_5ViewController ()

@end

@implementation Assignment_5ViewController

@synthesize button;
@synthesize label;

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
    //---create a CGRect for the positioning---
    CGRect frame = CGRectMake(20, 10, 280, 50);
    
    //---create a Label view---
    label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"Verdana" size:20];
    label.text = @"This is a label";
    label.backgroundColor = [UIColor lightGrayColor];
    
    //---create a Button view---
    frame = CGRectMake(20, 60, 280, 50);
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    [button setTitle: @"Ok" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    
    //---add the action handler and set the current class as target---
    [button addTarget:self
               action:@selector(buttonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //---add the views to the View Window---
    [self.view addSubview: label];
    [self.view addSubview:button];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)buttonClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Action invoked!"
                                                    message:@"Button Clicked!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
