//
//  UIImage+GeneralResize.m
//  Cinemek Hitchcock
//
//  Created by Jason Thane on 5/19/10.
//  Copyright 2010 General UI LLC. All rights reserved.
//

#import "UIImage+GeneralResize.h"


@implementation UIImage (GeneralResize)


// Return a scaled image with righted orientation
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL transpose = NO;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transpose = YES;
            break;
    }
    
    return [self resizedImage:newSize
                    transform:[self transformForOrientationWithSize:newSize]
               drawTransposed:transpose
         interpolationQuality:quality];
}


- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality
{
	CGFloat width = floor(newSize.width);
	CGFloat height = floor(newSize.height);
    
    CGRect transposedRect = CGRectMake(0, 0, height, width);
    CGImageRef imageRef = self.CGImage;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, 8, width * 4, CGImageGetColorSpace(imageRef), CGImageGetAlphaInfo(imageRef));
	
    CGContextConcatCTM(bitmap, transform);
    CGContextSetInterpolationQuality(bitmap, quality);
    CGContextDrawImage(bitmap, transpose ? transposedRect : CGRectMake(0, 0, width, height), imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
	
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Return a transform for righting the image's current orientation
- (CGAffineTransform)transformForOrientationWithSize:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3, 4
        case UIImageOrientationDownMirrored: 
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 5,6
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 7,8
        case UIImageOrientationRightMirrored: 
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (self.imageOrientation) {
			
		case UIImageOrientationLeftMirrored:   // EXIF = 5,7
        case UIImageOrientationRightMirrored: 
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
			
        case UIImageOrientationUpMirrored:     // EXIF = 2,4
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
			
    }
    
    return transform;
}



- (UIImage *) aspectFillResizeImageToSize:(CGSize)size
{
	
	CGSize currentSize = self.size;
	
	CGFloat wFactor = size.width / currentSize.width;
	CGFloat hFactor = size.height / currentSize.height;
	
	CGFloat scale = wFactor;
	if (hFactor > wFactor) scale = hFactor;
	
	currentSize.width = currentSize.width * scale;
	currentSize.height = currentSize.height * scale;
	
	return [self resizedImage: currentSize interpolationQuality: kCGInterpolationHigh];
}


- (UIImage*) maskImageWithMask:(UIImage *)maskImage
{
	CGImageRef maskRef = maskImage.CGImage; 
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
	CGImageRef masked = CGImageCreateWithMask([self CGImage], mask);
	
	return [UIImage imageWithCGImage:masked];
}

@end