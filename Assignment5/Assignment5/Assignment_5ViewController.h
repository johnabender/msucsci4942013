//
//  Assignment_5ViewController.h
//  Assignment5
//
//  Created by Andrew Wilson on 2/28/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Assignment_5ViewController : UIViewController <UIPickerViewDataSource,
UIPickerViewDelegate> {
    IBOutlet UITextField *name;
    IBOutlet UITextField *password;
    IBOutlet UIPickerView *weatherVariable;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
    UIImageView *tempImageView, *bgImageView;
    int prevPage;
}

@property (nonatomic, retain) UITextField *name;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) UIPickerView *weatherVariable;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIImageView *imageView1;
@property (nonatomic, retain) UIImageView *imageView2;

- (IBAction)loadValues:(id)sender;
- (IBAction)saveValues:(id)sender;
- (IBAction)doneEditing:(id)sender;

@end
