//
//  PCViewController.m
//  pagecontrol-demo
//
//  Created by John Bender on 2/1/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "PCViewController.h"

static const NSInteger kNumberOfPages = 3;

@interface PCViewController ()

@end

@implementation PCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    for( NSInteger i = 0; i < kNumberOfPages; i++ ) {
        CGRect frame;
        frame.size = scrollView.bounds.size;
        frame.origin.x = i*scrollView.frame.size.width;
        frame.origin.y = 0.;
        UIView *v = [[UIView alloc] initWithFrame:frame];

        switch( i ) {
            case 0:
                v.backgroundColor = [UIColor redColor];
                break;
            case 1:
                v.backgroundColor = [UIColor whiteColor];
                break;
            case 2:
                v.backgroundColor = [UIColor blueColor];
                break;
        }

        [scrollView addSubview:v];
    }

    scrollView.contentSize = CGSizeMake( kNumberOfPages*scrollView.frame.size.width, 0. );

    pageControl.currentPage = 0;
    pageControl.numberOfPages = kNumberOfPages;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) scrollViewDidScroll:(UIScrollView *)sv
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}


-(UIView*) viewForZoomingInScrollView:(UIScrollView *)sv
{
    // This function is required to make zooming work.
    // However, returning the first subview is wrong and zooming only partially works.
    // The real fix is more involved.
    return sv.subviews[0];
}


- (IBAction)pageChanged
{
    scrollView.contentOffset = CGPointMake( scrollView.frame.size.width*pageControl.currentPage, 0. );
}

@end
