//
//  MDAutoRetain.h
//  memory-demo
//
//  Created by John Bender on 1/17/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDAutoRetain : NSObject

@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy) NSString *copyString;
@property (nonatomic, weak) NSString *weakString;

@end
