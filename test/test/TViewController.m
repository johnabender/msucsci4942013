//
//  TViewController.m
//  test
//
//  Created by John Bender on 1/11/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "TViewController.h"
#import "TObject.h"


@implementation TViewController


-(void) setInteger:(NSInteger)newInteger
{
    // insert side effects here!
    _integer = newInteger;
}

-(NSInteger) integer
{
    return _integer;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    label.text = @"my custom text";

    someObj = [TObject new];
    int a = [someObj instanceMethod];
    int b = [TObject classMethod];
    DLog( @"%d %d", a, b );

    NSString *string = @"some string";
    NSArray *array = @[someObj, string];
    //NSArray *array = [NSArray arrayWithObjects:someObj, string, nil];
    id obj = array[0];
    //array[1] = @"another string";
    NSDictionary *dict = @{@"key1": someObj, @"key2": string, @"key3": array};
    id anotherObj = dict[@"key1"];
    //dict[@"key4"] = @"a third string";

    NSMutableString *mutableString;
    NSMutableArray *muArray = @[someObj, string];
    //muArray[1] = someObj;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) pressedButton
{
    DLog();
}

@end
