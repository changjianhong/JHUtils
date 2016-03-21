//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import "JHImageCache.h"
#import <UIKit/UIKit.h>

#define DEFAULT_CACHE_SIZE    5 * 1024 * 1024

@implementation JHImageCache

+ (JHImageCache *)sharedCache
{
  static JHImageCache *shareCache = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shareCache = [[JHImageCache alloc] init];
    [shareCache setTotalCostLimit:DEFAULT_CACHE_SIZE];
  });
  
  return shareCache;
}

- (void)setObject:(id)obj forKey:(id)key
{
  if ([obj isKindOfClass:[UIImage class]]) {
    [super setObject:obj forKey:key cost:[self imageDataSize:obj]];
  }
}

- (size_t)imageDataSize:(UIImage *)image
{
  size_t height      = (NSUInteger) image.size.height;
  size_t bytesPerRow = CGImageGetBytesPerRow(image.CGImage);
  
  if (bytesPerRow % 16) {
    bytesPerRow = ((bytesPerRow >> 4) + 1) << 4;
  }
  
  return height * bytesPerRow;
}

@end
