//
//  SObject2.m
//  serialization
//
//  Created by John Bender on 3/29/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "SObject2.h"

@implementation SObject2

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.name2 = [object valueForKey:keyPath];
}

@end
