//
//  CornerImageView.h
//  Student
//
//  Created by changjianhong on 16/3/18.
//  Copyright © 2016年 creatingev. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (Edit)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

- (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;

- (UIColor *)averageColor;

- (UIColor *)averageColorForRect:(CGRect)rect;

- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)scaleToSize:(CGSize)size;

- (UIImage *)scaleToAspectFillSize:(CGSize)size;

- (UIImage *)scaleToFillWidth:(CGFloat)width;

- (UIImage *)scaleWithRatio:(CGFloat)ratio;
@end