//
//  UIImage+Fit.m
//  Pods
//
//  Created by R0CKSTAR on 3/17/14.
//
//

#import "UIImage+Fit.h"

@implementation UIImage (Fit)

- (UIImage *)imageWithNewSize:(CGSize)newSize
{
    if (CGSizeEqualToSize(self.size, newSize) == NO) {
        CGFloat sourceWidth    = self.size.width;
        CGFloat sourceHeight   = self.size.height;
        CGFloat targetWidth    = newSize.width;
        CGFloat targetHeight   = newSize.height;
        CGFloat scaleFactor    = 0.0f;
        CGFloat scaledWidth    = targetWidth;
        CGFloat scaledHeight   = targetHeight;
        CGPoint thumbnailPoint = CGPointMake(0.0f ,0.0f);
        
        CGFloat widthFactor = targetWidth / sourceWidth;
        CGFloat heightFactor = targetHeight / sourceHeight;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;  // Fit height
        } else {
            scaleFactor = heightFactor; // Fit width
        }
        
        scaledWidth  = sourceWidth * scaleFactor;
        scaledHeight = sourceHeight * scaleFactor;
        
        if (widthFactor > heightFactor) {
            // V: Top align
            thumbnailPoint.y = 0;
        } else if (widthFactor < heightFactor) {
            // H: Center align
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, NO, self.scale);
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [self drawInRect:thumbnailRect];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    return self;
}

@end
