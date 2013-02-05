//
//  CSCI494FlipsideViewController.h
//  iOSAssignment1
//
//  Created by Andrew Wilson on 1/28/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSCI494FlipsideViewController;

@protocol CSCI494FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(CSCI494FlipsideViewController *)controller;
@end

@interface CSCI494FlipsideViewController : UIViewController

@property (weak, nonatomic) id <CSCI494FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
