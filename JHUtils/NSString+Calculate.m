//
//  NSString+Calculate.m
//  Student
//
//  Created by changjianhong on 16/2/18.
//  Copyright © 2016年 creatingev. All rights reserved.
//

#import "NSString+Calculate.h"

@implementation NSString (Calculate)

-(CGSize)singleLineSizeOfFont:(UIFont *)font{
  NSDictionary * attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
  return [self sizeWithAttributes:attributes];
}

- (CGSize)singleLineSizeOfFontFloat:(CGFloat)fontFloat
{
  UIFont * font = [UIFont systemFontOfSize:fontFloat];
  return [self singleLineSizeOfFont:font];
}

-(CGFloat)mutableLinesSizeOfFont:(UIFont *)font maxSize:(CGSize)maxSize{
  if (self.length <= 0) {
    return 0;
  }
  NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self
                                                                       attributes:@{NSFontAttributeName:font}];
  CGRect rect = [attributedText boundingRectWithSize:(CGSize){maxSize.width, maxSize.height}
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                             context:nil];
  return rect.size.height + 1;
}

@end
