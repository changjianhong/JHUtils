//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALayer (ImageExtend)

+ (CALayer *)layerWithImage:(UIImage *)image scale:(CGFloat)scale;

- (void)setContentImage:(UIImage *)image scale:(CGFloat)scale;

- (void)setContentImage:(UIImage *)image scale:(CGFloat)scale gravity:(NSString *)gravity;

@end
