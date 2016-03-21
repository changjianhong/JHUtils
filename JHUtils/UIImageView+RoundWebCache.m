//
//  UIImageView+RoundWebCache.m
//  Student
//
//  Created by changjianhong on 16/2/17.
//  Copyright © 2016年 creatingev. All rights reserved.
//

#import "UIImageView+RoundWebCache.h"
#import "UIImage+RoundCorner.h"

@implementation UIImageView (RoundWebCache)

- (void)rd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
{
  NSString * key = url.absoluteString;
  UIImage * tmpImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
  if (!tmpImage) {
    if (placeholderImage) {
      [self setImage:placeholderImage];
      [self setNeedsLayout];
    }
    [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
      if (finished) {
        if (image) {
          UIImage * roundImage = [image imageToCircle];
          if (roundImage) {
            [[SDWebImageManager sharedManager].imageCache storeImage:roundImage forKey:key];
            @weakify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
              @strongify(self);
              [self setImage:roundImage];
              [self setNeedsLayout];
            });
          }
        }
      }
    }];
  } else {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
      @strongify(self);
      [self setImage:tmpImage];
      [self setNeedsLayout];
    });
  }
}

@end
