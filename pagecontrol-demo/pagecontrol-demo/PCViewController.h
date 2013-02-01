//
//  PCViewController.h
//  pagecontrol-demo
//
//  Created by John Bender on 2/1/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCViewController : UIViewController <UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIPageControl *pageControl;
}

- (IBAction)pageChanged;

@end
