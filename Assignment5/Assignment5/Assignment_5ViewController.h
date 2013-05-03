//
//  Assignment_5ViewController.h
//  Assignment5
//
//  Created by Andrew Wilson on 2/28/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Export.h"

@interface Assignment_5ViewController : UIViewController <UIPickerViewDataSource,
UIPickerViewDelegate> {
    IBOutlet UIPickerView *weatherVariable;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
    UIImageView *tempImageView, *bgImageView;
    int prevPage;
    IBOutlet UITextView *valuesText;
    
    
    //---Create an instance of the view controller---
    Export *export;
}

@property (nonatomic, retain) UIPickerView *weatherVariable;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIImageView *imageView1;
@property (nonatomic, retain) UIImageView *imageView2;
@property (nonatomic, retain) UITextView *valuesText;

- (IBAction)loadValues:(id)sender;
- (IBAction)saveValues:(id)sender;
- (IBAction)doneEditing:(id)sender;


@end
