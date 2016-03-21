//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import "CALayer+ImageExtend.h"

@implementation CALayer (ImageExtend)

+ (CALayer *)layerWithImage:(UIImage *)image scale:(CGFloat)scale {
  CALayer *layer = [[CALayer alloc] init];
  layer.frame = (CGRect) {{0, 0}, image.size};
  layer.contents = (id)image.CGImage;
  layer.contentsScale = scale == 0 ? image.scale : scale;
  layer.contentsGravity = kCAGravityCenter;
  return layer;
}

- (void)setContentImage:(UIImage *)image scale:(CGFloat)scale {
  [self setContentImage:image scale:scale gravity:kCAGravityCenter];
}

- (void)setContentImage:(UIImage *)image scale:(CGFloat)scale gravity:(NSString *)gravity {
  self.contents = (id)image.CGImage;
  self.contentsScale = scale == 0 ? image.scale : scale;
  self.contentsGravity = gravity;
}

@end
