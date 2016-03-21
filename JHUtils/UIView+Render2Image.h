//
//  UIView+Render2Image.h
//  FullScreenPop
//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Render2Image)
-(UIImage*) renderToImage;
-(UIImage *)renderToImageBySize:(CGSize) size;
-(UIImage *)renderToImageBySize:(CGSize) size scale:(CGFloat)scale;
@end
