//
//  Export.h
//  Assignment5
//
//  Created by Andrew Wilson on 4/24/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Export : UIViewController
{
    UIButton *button;
}

//---expose the outlet as a property---
@property (nonatomic, retain) UIButton *button;

@end
