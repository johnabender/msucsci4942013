//
//  CSCI494FlipsideViewController.m
//  AssignmentTWO
//
//  Created by Andrew Wilson on 2/5/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import "CSCI494FlipsideViewController.h"

@interface CSCI494FlipsideViewController ()

@end

@implementation CSCI494FlipsideViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

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

- (IBAction)Red:(id)sender
{
    CGRect frame = CGRectMake(60, 100, 200, 200);
    subView = [[UIView alloc] initWithFrame:frame];
    subView.backgroundColor = [UIColor redColor];
    [self.view addSubview:subView];
}
- (IBAction)Blue:(id)sender
{
    CGRect frame = CGRectMake(60, 100, 200, 200);
    subView = [[UIView alloc] initWithFrame:frame];
    subView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:subView];
}
- (IBAction)Green:(id)sender
{
    CGRect frame = CGRectMake(60, 100, 200, 200);
    subView = [[UIView alloc] initWithFrame:frame];
    subView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:subView];
}
- (IBAction)Draw:(id)sender
{
    UIBezierPath *myPath=[[UIBezierPath alloc]init];
    myPath.lineWidth=10;
    //    brushPattern=[UIColor redColor]; //This is the color of my stroke
    
}

@end