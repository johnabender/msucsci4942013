//
//  CSCI494FlipsideViewController.h
//  AssignmentTWO
//
//  Created by Andrew Wilson on 2/5/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSCI494FlipsideViewController;

@protocol CSCI494FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(CSCI494FlipsideViewController *)controller;
@end

@interface CSCI494FlipsideViewController : UIViewController
{
    UIBezierPath *path;
    UIView *subView;
}

@property (weak, nonatomic) id <CSCI494FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)Red:(id)sender;
- (IBAction)Blue:(id)sender;
- (IBAction)Green:(id)sender;
- (IBAction)Draw:(id)sender;


@end
