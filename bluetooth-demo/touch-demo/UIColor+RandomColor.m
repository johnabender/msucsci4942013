//
//  UIColor+RandomColor.m
//  general-code
//
//  Created by John Bender on 1/23/13.
//
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+(UIColor*) randomColor
{
    CGFloat r = (CGFloat)rand()/(CGFloat)RAND_MAX;
    CGFloat g = (CGFloat)rand()/(CGFloat)RAND_MAX;
    CGFloat b = (CGFloat)rand()/(CGFloat)RAND_MAX;
    return [self colorWithRed:r green:g blue:b alpha:1.];
}

@end
