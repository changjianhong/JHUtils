//
//  UIView+Render2Image.m
//  FullScreenPop
//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import "UIView+Render2Image.h"

@implementation UIView (Render2Image)

- (UIImage*) renderToImage
{
  return [self renderToImageBySize:self.bounds.size];
}

-(UIImage *)renderToImageBySize:(CGSize) size{
  return [self renderToImageBySize:size scale:0.0];
}

-(UIImage *)renderToImageBySize:(CGSize) size scale:(CGFloat)scale{
  UIGraphicsBeginImageContextWithOptions(size, self.opaque, scale);
  [self.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@end
