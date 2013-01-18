//
//  MDRetainer.m
//  memory-demo
//
//  Created by John Bender on 1/17/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "MDRetainer.h"

@implementation MDRetainer

-(id) init
{
    self = [super init];

    needsInitialization = TRUE;

    return self;
}

-(id) retain
{
    id retVal = [super retain];
    DLog( @"%d", self.retainCount );
    return retVal;
}

-(void) release
{
    [super release];
    DLog( @"%d", self.retainCount );
}

-(void) dealloc
{
    [obj release];

    [super dealloc];
}


-(void) doSomething
{
}


@end
