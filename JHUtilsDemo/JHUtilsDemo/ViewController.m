//
//  ViewController.m
//  JHUtilsDemo
//
//  Created by changjianhong on 16/3/21.
//  Copyright © 2016年 changjianhong. All rights reserved.
//

#import "ViewController.h"
#import "JHActionSheet.h"
#import "CornerImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CornerImageView *cornerImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.cornerImageView setImage:[UIImage imageNamed:@"1.jpg"]];
}

- (IBAction)actionSheet:(id)sender {
  JHActionSheet *actionSheet = [[JHActionSheet alloc] init];
  [actionSheet addButtonWithTitle:@"确定" block:^(NSInteger buttonIndex) {
    
  }];
  
  [actionSheet setCancelButtonWithTitle:@"取消" block:^(NSInteger buttonIndex) {
    
  }];
  
  [actionSheet showInView:self.view];
}

@end
