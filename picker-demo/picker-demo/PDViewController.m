//
//  PDViewController.m
//  picker-demo
//
//  Created by John Bender on 2/22/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "PDViewController.h"

@interface PDViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UIPickerView *picker;
}

-(IBAction) tappedDatePicker;
-(IBAction) tappedPicker;

@end

@implementation PDViewController

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


-(IBAction) tappedDatePicker
{
    NSLog( @"date picker picked %@", datePicker.date );
}

-(IBAction) tappedPicker
{
    NSLog( @"picked row %d", [picker selectedRowInComponent:0] );
}


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(UIView*) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake( 0., 0., 25., 25. )];
    v.backgroundColor = [UIColor greenColor];
    return v;
}

@end
