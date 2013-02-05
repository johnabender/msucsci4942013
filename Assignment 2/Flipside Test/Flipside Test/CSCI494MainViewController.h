//
//  CSCI494MainViewController.h
//  Flipside Test
//
//  Created by Andrew Wilson on 1/29/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import "CSCI494FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface CSCI494MainViewController : UIViewController <CSCI494FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
