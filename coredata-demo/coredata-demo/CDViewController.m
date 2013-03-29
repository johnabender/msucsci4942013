//
//  CDViewController.m
//  coredata-demo
//
//  Created by John Bender on 3/29/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "CDViewController.h"
#import "FirstObject.h"
#import "CDAppDelegate.h"

#define APP_DELEGATE ((CDAppDelegate*)[[UIApplication sharedApplication] delegate])

@interface CDViewController ()

@end

@implementation CDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        FirstObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"FirstObject"
                                                         inManagedObjectContext:APP_DELEGATE.managedObjectContext];
        [APP_DELEGATE saveContext];
        NSLog( @"object %@ creation date %@", obj, obj.dateCreated );
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSFetchRequest *fetch = [NSFetchRequest new];
    fetch.entity = [NSEntityDescription entityForName:@"FirstObject"
                               inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    NSArray *objects = [APP_DELEGATE.managedObjectContext executeFetchRequest:fetch error:nil];
    NSLog( @"%@", objects );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
