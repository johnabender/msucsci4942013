//
//  DPDViewController.m
//  design-pattern-demo
//
//  Created by John Bender on 1/17/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "DPDViewController.h"
#import "NSString+sha256.h"

@interface DPDViewController ()
{
    NSString *myString;
}

-(void) func:(NSURLRequest*)req;

@end


@implementation DPDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [button addTarget:self action:@selector(pressedButton1) forControlEvents:UIControlEventTouchUpInside];

    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://montana.edu"]];
    [NSURLConnection connectionWithRequest:req delegate:self];
    NSLog( @"connection started" );


    [[NSOperationQueue new] addOperationWithBlock:^{
        NSLog( @"function executing with req %@", req );
    }];

    [self performSelectorInBackground:@selector(func:) withObject:req];
    [self performSelector:@selector(func:) withObject:req];
    [self performSelectorOnMainThread:@selector(func:) withObject:req waitUntilDone:YES];
    NSLog( @"functions away" );
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) func:(NSURLRequest*)req
{
    NSLog( @"function executing with req %@", req );
}


-(IBAction) pressedButton0
{
    NSLog( @"pressed button 0" );
    NSString *string = @"a string";
    NSLog( @"%@ %@", string, [string sha256] );
}


-(void) pressedButton1
{
    NSLog( @"pressed button 1" );
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog( @"connection received response %@", response );
}

@end
