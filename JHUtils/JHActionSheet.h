//
//  Created by changjianhong on 16/1/30.
//  Copyright © 2016年 creatingev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HandleBlock)(NSInteger buttonIndex);

@interface JHActionSheet : UIView

- (void)showInView:(UIView *)view;

- (void)addMessage:(NSString *)message;

- (void)addButtonWithTitle:(NSString *)title block:(HandleBlock)block;

- (void)setCancelButtonWithTitle:(NSString *)title block:(HandleBlock)block;

@end
