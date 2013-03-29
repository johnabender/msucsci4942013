//
//  FirstObject.m
//  coredata-demo
//
//  Created by John Bender on 3/29/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "FirstObject.h"

@implementation FirstObject

@dynamic dateCreated;
@dynamic secondObjects;

@synthesize userData = _userData;

-(void) awakeFromInsert
{
    [super awakeFromInsert];
    
    self.dateCreated = [NSDate date];
}

@end
