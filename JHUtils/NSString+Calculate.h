//
//  NSString+Calculate.h
//  Student
//
//  Created by changjianhong on 16/2/18.
//  Copyright © 2016年 creatingev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Calculate)

- (CGSize)singleLineSizeOfFontFloat:(CGFloat)fontFloat;

-(CGSize)singleLineSizeOfFont:(UIFont *)font;

-(CGFloat)mutableLinesSizeOfFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
