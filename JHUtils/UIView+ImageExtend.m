//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import "UIView+ImageExtend.h"
#import "CALayer+ImageExtend.h"
#import <objc/runtime.h>

static void *kBackgroundImageKey = &kBackgroundImageKey;

@implementation UIView (ImageExtend)

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
  [self.layer setContentImage:backgroundImage scale:0];
  objc_setAssociatedObject(self, &kBackgroundImageKey, backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)backgroundImage
{
  return objc_getAssociatedObject(self, &kBackgroundImageKey);
}

- (void)setBackgroundPattern:(UIImage *)backgroundPattern
{
  self.backgroundColor = [UIColor colorWithPatternImage:backgroundPattern];
  objc_setAssociatedObject(self, &kBackgroundImageKey, backgroundPattern, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)backgroundPattern
{
  return objc_getAssociatedObject(self, &kBackgroundImageKey);
}

- (UIViewController *)parenViewController
{
  UIResponder *responder = [self nextResponder];
  while (responder) {
    if ([responder isKindOfClass:[UIViewController class]]) {
      return (UIViewController *) responder;
    }
    responder = [responder nextResponder];
  }
  return nil;
}

@end
