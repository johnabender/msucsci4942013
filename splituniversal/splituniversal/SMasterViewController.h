//
//  SMasterViewController.h
//  splituniversal
//
//  Created by John Bender on 2/1/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDetailViewController;

@interface SMasterViewController : UITableViewController

@property (strong, nonatomic) SDetailViewController *detailViewController;

@end
