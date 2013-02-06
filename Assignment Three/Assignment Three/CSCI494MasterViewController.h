//
//  CSCI494MasterViewController.h
//  Assignment Three
//
//  Created by Andrew Wilson on 2/6/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSCI494DetailViewController;

#import <CoreData/CoreData.h>

@interface CSCI494MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) CSCI494DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
