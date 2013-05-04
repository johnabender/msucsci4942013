-//
2    	
-//  CSCI494MainViewController.h
3	  	
-//  Flipside Test
4	  	
-//
5	  	
-//  Created by Andrew Wilson on 1/29/13.
6	  	
-//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
7	  	
-//
8	  	
-
9	  	
-#import "CSCI494FlipsideViewController.h"
10	  	
-
11	  	
-#import <CoreData/CoreData.h>
12	  	
-
13	  	
-@interface CSCI494MainViewController : UIViewController <CSCI494FlipsideViewControllerDelegate>
14	  	
-
15	  	
-@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
16	  	
-
17	  	
-@end
