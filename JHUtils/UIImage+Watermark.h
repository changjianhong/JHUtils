//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Watermark)

- (UIImage *)addDefaultWaterMark;
- (UIImage *)imageWithWatermark:(UIImage *)watermark rect:(CGRect)rect;

@end
