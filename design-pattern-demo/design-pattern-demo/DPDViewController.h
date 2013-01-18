//
//  DPDViewController.h
//  design-pattern-demo
//
//  Created by John Bender on 1/17/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPDViewController : UIViewController <NSURLConnectionDelegate>
{
    __weak IBOutlet UIButton *button;
}

-(IBAction) pressedButton0;
-(void) pressedButton1;

@end
