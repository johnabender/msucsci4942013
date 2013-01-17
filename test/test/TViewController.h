//
//  TViewController.h
//  test
//
//  Created by John Bender on 1/11/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TObject;

@interface TViewController : UIViewController
{
@private
    TObject *someObj;
    BOOL hasInitialized;


    IBOutlet UILabel *label;
    IBOutlet UIButton *button;


@protected
    CGFloat fl;

    NSInteger _integer;

}

@property NSInteger integer;

//-(void) setInteger:(NSInteger)newInteger;
//-(NSInteger) integer;

-(IBAction) pressedButton;


@end
