//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import "UITableView+VisibleIndexPath.h"

@implementation UITableView (VisibleIndexPath)

-(BOOL)isVisibleWholeIndexPath:(NSIndexPath *) indexPath{
  CGRect rect = [self rectForRowAtIndexPath:indexPath];
  return CGRectContainsRect(CGRectMake(self.contentOffset.x, self.contentOffset.y, self.frame.size.width, self.frame.size.height), rect);
}

@end
