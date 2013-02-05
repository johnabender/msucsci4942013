//
//  CSCI494FlipsideViewController.h
//  Flipside Test
//
//  Created by Andrew Wilson on 1/29/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSCI494FlipsideViewController;

@protocol CSCI494FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(CSCI494FlipsideViewController *)controller;
@end

@interface CSCI494FlipsideViewController : UIView 
{
UIView *subView;
UIBezierPath *path;
}

@property (weak, nonatomic) id <CSCI494FlipsideViewControllerDelegate> delegate;


- (IBAction)Draw:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)Red:(id)sender;
- (IBAction)Blue:(id)sender;
- (IBAction)Green:(id)sender;

@end

