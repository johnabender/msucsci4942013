//
//  CDViewController.m
//  control-temo
//
//  Created by John Bender on 2/13/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "CDViewController.h"

@interface CDViewController () <UIAlertViewDelegate, UIActionSheetDelegate>
{
    __weak IBOutlet UILabel *sliderLabel;
    __weak IBOutlet UILabel *switchLabel;
    __weak IBOutlet UILabel *segmentLabel;
    __weak IBOutlet UILabel *progressLabel;
    __weak IBOutlet UILabel *stepperLabel;

    __weak IBOutlet UIProgressView* progressBar;
}

-(IBAction) movedSlider:(UISlider*)slider;
-(IBAction) flippedSwitch:(UISwitch*)s;
-(IBAction) switchedSegments:(UISegmentedControl*)segmentedControl;
-(IBAction) incrementedStepper:(UIStepper*)stepper;

@end

@implementation CDViewController

-(IBAction) movedSlider:(UISlider*)slider
{
    sliderLabel.text = [NSString stringWithFormat:@"%.f", slider.value];
}

-(IBAction) flippedSwitch:(UISwitch*)s
{
    switchLabel.text = [NSString stringWithFormat:@"%d", s.on];

    if( s.on ) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"newViewController"];
        [self presentViewController:newViewController animated:YES completion:NULL];
    }
}

-(IBAction) switchedSegments:(UISegmentedControl*)segmentedControl
{
    segmentLabel.text = [segmentedControl titleForSegmentAtIndex:segmentedControl.selectedSegmentIndex];

    if( segmentedControl.selectedSegmentIndex == 1 ) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Take an Action!"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:@"Destroy"
                                                        otherButtonTitles:@"Option One", @"Option Two", nil];
        [actionSheet showInView:self.view];
    }
}

-(IBAction) incrementedStepper:(UIStepper*)stepper
{
    stepperLabel.text = [NSString stringWithFormat:@"%.f", stepper.value];
    [progressBar setProgress:stepper.value/100.f animated:YES];
    progressLabel.text = [NSString stringWithFormat:@"%@%%", stepperLabel.text];

    if( stepper.value == 0. ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert! Alert!"
                                                        message:@"This is the message."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Button One", @"Button Two", nil];
        [alert show];
    }
}


-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog( @"alert view dismissed with button %d", buttonIndex );
}


-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog( @"action sheet dismissed with button %d", buttonIndex );
}

@end
