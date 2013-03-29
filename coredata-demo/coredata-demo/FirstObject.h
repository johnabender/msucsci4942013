//
//  FirstObject.h
//  coredata-demo
//
//  Created by John Bender on 3/29/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SecondObject.h"

@interface FirstObject : NSManagedObject

@property NSDate *dateCreated;
@property NSSet *secondObjects;

@property (nonatomic, copy) NSString *userData;

@end
