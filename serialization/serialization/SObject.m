//
//  SObject.m
//  serialization
//
//  Created by John Bender on 3/29/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "SObject.h"

@implementation SObject

-(BOOL) validateName:(NSString**)nameValue error:(NSError*)error
{
    if( [*nameValue isEqualToString:@"some name"] )
        return NO;
    return YES;
}

@end
