//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import "UIImage+CompressForUpload.h"

@implementation UIImage (CompressForUpload)

- (NSData*)getLessMemoryImageData
{
  CGFloat scaleFactor = [self getCompressScaleFactor:self];
  UIImage* newImage = [self compressImageWithFactor:scaleFactor];
  return [self compressImage:newImage];
}

- (UIImage*)getQuarterSizeImage
{
  return [self compressImageWithFactor:2];
}

- (UIImage*)compressImageWithFactor:(CGFloat)factor
{
  CGSize newSize = CGSizeMake(floor(self.size.width / factor), floor(self.size.height / factor));
  UIGraphicsBeginImageContext(newSize);
  // Tell the old image to draw in this new context, with the desired
  // new size
  [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
  // Get the new image from the context
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  // End the context
  UIGraphicsEndImageContext();
  return newImage;
}

- (NSData*)compressImage:(UIImage*)image
{
  CGFloat effectiveFactor = 0.6;
  return UIImageJPEGRepresentation(image, effectiveFactor);
}

- (CGFloat)getCompressScaleFactor:(UIImage*)image
{
  size_t imageSize = CGImageGetBytesPerRow(image.CGImage) * CGImageGetHeight(image.CGImage);
  size_t maxSize = 9196108; //
  if (imageSize > maxSize) {
    return sqrtf(imageSize / maxSize);
  } else {
    return 1;
  }
}

@end
