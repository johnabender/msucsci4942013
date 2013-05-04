//
//  Assignment 5ViewController.h
//  Assignment5
//
//  Created by Andrew Wilson on 4/23/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Assignment_5ViewController : UIViewController
{
    //---create two outlets - lavel and button---
    UILabel *label;
    UIButton *button;
}

//---expose the outlets as properties---
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIButton *button;

//---declaring the IBAction---
-(IBAction)buttonClicked:(id)sender;

@end
