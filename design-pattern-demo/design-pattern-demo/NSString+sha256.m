//
//  NSString+sha256.m
//  design-pattern-demo
//
//  Created by John Bender on 1/17/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "NSString+sha256.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (sha256)

-(NSString*) sha256
{
	const char *str = [self UTF8String];
	unsigned char sha[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256( str, strlen( str ), sha );
    NSMutableString *returnString = [NSMutableString new];
    for( NSInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++ )
        [returnString appendFormat:@"%02X", sha[i]];
    return returnString;
}

@end
