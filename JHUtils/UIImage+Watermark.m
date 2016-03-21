//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import "UIImage+Watermark.h"

static CGFloat const kWatermarkAlpha = 0.5;
static CGFloat const kRightMargin = 16;
static CGFloat const kBottomMargin = 12;

@implementation UIImage (Watermark)

- (UIImage *)addDefaultWaterMark {
  UIImage *watermark = [UIImage imageNamed:@"pic_watermark"];
  CGFloat markWidth = watermark.size.width;
  CGFloat markHeight = watermark.size.height;
  CGFloat widthRatio = (markWidth+kRightMargin) / self.size.width;
  CGFloat heightRatio = (markHeight+kBottomMargin) / self.size.height;
  CGFloat aspectRatio = watermark.size.width / watermark.size.height;
  if ((widthRatio > heightRatio) && (widthRatio > 0.5)) { //按宽度等比缩放
    markWidth = self.size.width * 0.5 - kRightMargin;
    markHeight = markWidth / aspectRatio;
  } else if ((heightRatio > widthRatio) && (heightRatio > 0.5)) { //按高度等比缩放
    markHeight = self.size.height * 0.5 - kBottomMargin;
    markWidth = markHeight * aspectRatio;
  }
  
  CGRect rect = CGRectMake(self.size.width-watermark.size.width-kRightMargin,
                           self.size.height-watermark.size.height-kBottomMargin,
                           watermark.size.width,
                           watermark.size.height);
  return [self imageWithWatermark:watermark rect:rect];
}

- (UIImage *)imageWithWatermark:(UIImage *)watermark rect:(CGRect)rect {
  UIGraphicsBeginImageContext(self.size);
  [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
  [watermark drawInRect:rect blendMode:kCGBlendModeNormal alpha:kWatermarkAlpha];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  return image;
}

@end
