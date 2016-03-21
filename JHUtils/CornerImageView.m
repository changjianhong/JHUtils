//
//  CornerImageView.m
//  Student
//
//  Created by changjianhong on 16/3/18.
//  Copyright © 2016年 creatingev. All rights reserved.
//

#define kDetailImageSize 100
#define kCornerImageViewKey @"CornerImageViewKey"

#import "CornerImageView.h"
#import "UIImage+RoundCorner.h"
#import "JHImageCache.h"

@interface CornerImageView()
@property (nonatomic, strong) CALayer *sublayer;
@end

@implementation CornerImageView

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    [self setUp];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super initWithCoder:aDecoder]) {
    [self setUp];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  self.sublayer.frame = self.bounds;
}

- (void)setUp
{
  self.sublayer = [CALayer layer];
//  CFBridgingRelease  崩溃
  UIImage * image = [self getIncircleImage];//[UIImage imageNamed:@"ic_clear_circle_30"];
  CGImageRef imageRef = image.CGImage;
  self.sublayer.contents = (__bridge id _Nullable)(imageRef);
  [self.layer addSublayer:self.sublayer];
}

- (UIImage *)getIncircleImage
{
  UIImage * image = [[JHImageCache sharedCache] objectForKey:kCornerImageViewKey];
  if (image) {
    return image;
  }
  image = [UIImage incircleImageBySize:CGSizeMake(kDetailImageSize, kDetailImageSize) outColor:[UIColor whiteColor]];
  [[JHImageCache sharedCache] setObject:image forKey:kCornerImageViewKey];
  
//  UIImage * image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:kCornerImageViewKey];
//  if (image) {
//    return image;
//  }
//  image = [UIImage incircleImageBySize:CGSizeMake(kDetailImageSize, kDetailImageSize) outColor:[UIColor whiteColor]];
//  [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:nil forKey:kCornerImageViewKey toDisk:YES];
  return image;
}

- (void)dealloc
{
  NSLog(@"cornerImageView dealloc....");
}

@end
