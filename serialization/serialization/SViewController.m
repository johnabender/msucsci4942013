//
//  SViewController.m
//  serialization
//
//  Created by John Bender on 3/29/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "SViewController.h"
#import "SObject.h"
#import "SObject2.h"

@interface SViewController ()
{
    SObject *s;
    SObject2 *s2;
}

@end

@implementation SViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    s2 = [SObject2 new];

    s = [SObject new];
    [s addObserver:s2 forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

    NSString *string = @"some name";
    if( [s validateValue:&string forKey:@"name" error:nil] )
        [s setValue:@"some name" forKey:@"name"];
    NSLog( @"initial name is %@", [s valueForKey:@"name"] );
    NSLog( @"s2's name is now %@", s2.name2 );
    s.name = @"another name";
    NSLog( @"name is now %@", s.name );
    NSLog( @"...and s2's name has changed to %@", s2.name2 );

    NSLog( @"stored name is %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"MyNameKey"] );
    [[NSUserDefaults standardUserDefaults] setObject:@"my name again" forKey:@"MyNameKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
