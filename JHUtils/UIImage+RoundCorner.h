//
//  UIImage+RoundCorner.h
//  Student
//
//  Created by changjianhong on 15/12/29.
//  Copyright © 2015年 creatingev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundCorner)
- (UIImage *)imageToCircle;
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin;

+ (UIImage *)incircleImageBySize:(CGSize)size outColor:(UIColor *)color;

@end
