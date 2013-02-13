//
//  SDWebViewController.m
//  scroll-demo
//
//  Created by John Bender on 2/13/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "SDWebViewController.h"

@interface SDWebViewController ()
{
    __weak IBOutlet UIWebView* webView;
}

@end

@implementation SDWebViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"test-file" withExtension:@"html"];
    NSString *html = [NSString stringWithContentsOfURL:htmlURL encoding:NSASCIIStringEncoding error:nil];
    [webView loadHTMLString:html baseURL:nil];
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://apple.com"]]];
}

@end
