//
//  CDNewViewController.m
//  control-temo
//
//  Created by John Bender on 2/13/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "CDNewViewController.h"

@interface CDNewViewController ()

-(IBAction) dismiss;

@end

@implementation CDNewViewController

-(IBAction) dismiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
