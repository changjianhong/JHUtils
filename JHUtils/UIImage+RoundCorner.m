//
//  UIImage+RoundCorner.m
//  Student
//
//  Created by changjianhong on 15/12/29.
//  Copyright © 2015年 creatingev. All rights reserved.
//

#import "UIImage+RoundCorner.h"

@implementation UIImage (RoundCorner)

- (UIImage *)imageToCircle
{
  CGFloat minSize = MIN(self.size.width, self.size.height);
  if (self.size.width != self.size.height) {
    CGRect rect = CGRectMake(0, 0, minSize, minSize);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    [self drawInRect:rect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage * tmpImage = [newImage imageByRoundCornerRadius:minSize/2 borderWidth:1 borderColor:[UIColor colorWithWhite:0 alpha:0.1]];
    return tmpImage;
  }
  return [self imageByRoundCornerRadius:minSize/2 borderWidth:1 borderColor:[UIColor colorWithWhite:0 alpha:0.1]];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius {
  return [self imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor {
  return [self imageByRoundCornerRadius:radius
                                corners:UIRectCornerAllCorners
                            borderWidth:borderWidth
                            borderColor:borderColor
                         borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin {
  
  UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
  CGContextScaleCTM(context, 1, -1);
  CGContextTranslateCTM(context, 0, -rect.size.height);
  CGFloat minSize = MIN(self.size.width, self.size.height);
  if (borderWidth < minSize / 2) {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
    [path closePath];
    CGContextSaveGState(context);
    [path addClip];
    CGContextDrawImage(context, rect, self.CGImage);
    CGContextRestoreGState(context);
  }
  
  if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
    CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
    CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
    CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
    [path closePath];
    
    path.lineWidth = borderWidth;
    path.lineJoinStyle = borderLineJoin;
    [borderColor setStroke];
    [path stroke];
  }
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

+ (UIImage *)incircleImageBySize:(CGSize)size outColor:(UIColor *)color
{
  CGRect rect = CGRectMake(0, 0, size.width, size.height);
  UIGraphicsBeginImageContext(size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, color.CGColor);
  CGContextFillRect(context, rect);
  CGContextAddEllipseInRect(context, rect);
  CGContextClip(context);
  CGContextClearRect(context, rect);
  UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
  
  
  
}


@end
