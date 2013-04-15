//
//  UIImage+GeneralResize.h
//  Cinemek Hitchcock
//
//  Created by Jason Thane on 5/19/10.
//  Copyright 2010 General UI LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (GeneralResize)

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize transform:(CGAffineTransform)transform drawTransposed:(BOOL)transpose interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientationWithSize:(CGSize)newSize;

- (UIImage*) aspectFillResizeImageToSize:(CGSize)size;
- (UIImage*) maskImageWithMask:(UIImage *)maskImage;

@end
