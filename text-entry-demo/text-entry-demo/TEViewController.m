//
//  TEViewController.m
//  text-entry-demo
//
//  Created by John Bender on 2/22/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "TEViewController.h"

@interface UIView (HideKeyboard)
@end

@implementation UIView (HideKeyboard)
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
@end


@interface TEViewController () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation TEViewController

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

-(IBAction) pressedHideKeyboard
{
    NSLog( @"button hiding keyboard" );
    [self.view endEditing:YES];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *number = [formatter numberFromString:textField.text];
    NSLog( @"number was %@", number );

    CGFloat floatNum = [textField.text floatValue];
    NSLog( @"float value was %f", floatNum );

    return YES;
}

@end
