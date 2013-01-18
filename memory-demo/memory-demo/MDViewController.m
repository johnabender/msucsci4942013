//
//  MDViewController.m
//  memory-demo
//
//  Created by John Bender on 1/17/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "MDViewController.h"
#import "MDRetainer.h"
#import "MDAutoRetain.h"

@interface MDViewController ()

@end

@implementation MDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    /*
    MDRetainer *r0 = [MDRetainer new];
    [r0 retain];
    [r0 release];
    [r0 release];

    MDRetainer *r1 = [[MDRetainer alloc] init];
    [r1 retain];
    [r1 release];
    [r1 autorelease];

    [r1 doSomething];
     */

    MDAutoRetain *a = [MDAutoRetain new];
    NSString *string = @"a string";
    a.strongString = string;
    a.copyString = string;
    a.weakString = string;

    string = nil;
    NSString *utf = [string pathComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
