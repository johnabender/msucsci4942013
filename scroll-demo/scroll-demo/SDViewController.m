//
//  SDViewController.m
//  scroll-demo
//
//  Created by John Bender on 2/13/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "SDViewController.h"

@interface SDViewController () <UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *zoomView;
}

@end

@implementation SDViewController

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    static const CGFloat viewSize = 50.;
    static const NSInteger numberOfViews = 20;

    for( NSInteger i = 0; i < numberOfViews; i++ ) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake( i*viewSize, i*viewSize, viewSize, viewSize )];
        v.backgroundColor = [UIColor greenColor];
        [zoomView addSubview:v];
    }

    scrollView.contentSize = CGSizeMake( numberOfViews*viewSize, numberOfViews*viewSize );
}

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return zoomView;
}

@end
