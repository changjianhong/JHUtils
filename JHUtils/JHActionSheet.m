//
//  Created by changjianhong on 16/1/30.
//  Copyright © 2016年 creatingev. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "JHActionSheet.h"
#import "NSString+Calculate.h"
#import "UIView+Utils.h"

static const CGFloat kSectionHeight = 6.0;
static const CGFloat KEdges = 10.0;
static const CGFloat KMinButtonHeight = 50.0;

@interface JHActionSheetModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) HandleBlock handleBlock;
@property (nonatomic, assign) CGFloat font;

@end

@implementation JHActionSheetModel

- (NSInteger)height
{
  CGFloat height = [_title mutableLinesSizeOfFont:[UIFont systemFontOfSize:_font] maxSize:CGSizeMake(kScreenWidth - KEdges * 2, HUGE)];
  height += KEdges * 2;
  return MAX(height, KMinButtonHeight);
}

@end

@interface JHActionSheetCell : UITableViewCell

@end

@implementation JHActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    [self.textLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabel setFont:[UIFont systemFontOfSize:18]];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  self.textLabel.frame = CGRectMake(KEdges, 0, self.contentView.width - KEdges * 2, self.contentView.height);
  UIView * view = [self valueForKey:@"_separatorView"];
  if (view) {
    CGRect frame = view.frame;
    frame.origin.x = 0.;
    frame.size.width = CGRectGetWidth(self.bounds);
    view.frame = frame;
  }
}

@end

@interface JHActionSheetHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView * separatorView;

@end

@implementation JHActionSheetHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_titleLabel];
    _separatorView = [[UIView alloc] init];
    [self.contentView addSubview:_separatorView];
    [_separatorView setBackgroundColor:[UIColor colorWithWhite:0.85 alpha:1.0]];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  [_titleLabel setFrame:CGRectMake(KEdges, 0, self.width, self.height -1)];
  [_separatorView setFrame:CGRectMake(0, _titleLabel.height, self.width, 0.5)];
}

@end

@interface JHActionSheet()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *otherModels;
@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, strong) JHActionSheetModel *cancelModel;
@property (nonatomic, strong) JHActionSheetModel *messageModel;
@property (nonatomic, assign) NSInteger cancelButtonIndex;

@end

@implementation JHActionSheet

- (id)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    _otherModels = [NSArray array];
    self.backgroundColor = [UIColor colorWithWhite:0.333 alpha:0.3];
  }
  return self;
}

- (void)addMessage:(NSString *)message
{
  JHActionSheetModel * model = [[JHActionSheetModel alloc] init];
  model.font = 14.0;
  model.title = message;
  self.messageModel = model;
}

- (void)addButtonWithTitle:(NSString *)title block:(HandleBlock)block
{
  JHActionSheetModel * model = [[JHActionSheetModel alloc] init];
  model.font = 18.0;
  model.handleBlock = block;
  model.title = title;
  self.otherModels = [[NSArray arrayWithArray:self.otherModels] arrayByAddingObject:model];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(HandleBlock)block
{
  JHActionSheetModel * model = [[JHActionSheetModel alloc] init];
  model.handleBlock = block;
  model.font = 18.0;
  model.title = title;
  self.cancelModel = model;
  self.cancelButtonIndex = self.otherModels.count;
}

#pragma UI

- (void)showInView:(UIView *)view
{
  UIWindow *statusBarWindow = [self statusBarWindow];
  CGRect rect = statusBarWindow.bounds;
  [self setFrame:rect];
  [statusBarWindow addSubview:self];
  [self addSubview:self.tableView];
  [UIView animateWithDuration:0.5 animations:^{
    self.tableView.frame = CGRectMake(0, kScreenHeight - self.tableViewHeight, kScreenWidth, self.tableViewHeight);
  }];
}

- (UIWindow *)statusBarWindow {
  return [[UIApplication sharedApplication] valueForKey:@"_statusBarWindow"];
}

- (void)dismiss
{
  [UIView animateWithDuration:0.5 animations:^{
    self.tableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.tableViewHeight);
  } completion:^(BOOL finished) {
    [self removeFromSuperview];
  }];
}

- (UITableView *)tableView
{
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, self.tableViewHeight) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    [_tableView registerClass:[JHActionSheetCell class] forCellReuseIdentifier:NSStringFromClass([JHActionSheetCell class])];
    [_tableView registerClass:[JHActionSheetHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JHActionSheetHeaderView class])];
    _tableView.rowHeight = 44.0;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
  }
  return _tableView;
}

- (CGFloat)tableViewHeight
{
  if (!_tableViewHeight) {
    CGFloat height = 0.0;
    if (_messageModel) {
      height = _messageModel.height;
    }
    
    if (_otherModels) {
      for (JHActionSheetModel * model in _otherModels) {
        height += model.height;
      }
    }
    
    if (_cancelModel) {
      height += _cancelModel.height;
    }
    _tableViewHeight = height + kSectionHeight;
  }
  return _tableViewHeight;
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return  section == 0 ? self.otherModels.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  JHActionSheetModel * model;
  if (indexPath.section == 1) {
    model = self.cancelModel;
  } else {
    model = self.otherModels[indexPath.row];
  }
  JHActionSheetCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JHActionSheetCell class])
                                                             forIndexPath:indexPath];
  [cell.textLabel setText:model.title];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  JHActionSheetModel * model;
  if (indexPath.section == 1) {
    model = self.cancelModel;
  } else {
    model = self.otherModels[indexPath.row];
  }
  return model.height;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  if (section == 0 && _messageModel) {
    JHActionSheetHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JHActionSheetHeaderView class])];
    headerView.titleLabel.text = _messageModel.title;
    return headerView;
  }
  UIView *view = [[UIView alloc] init];
  view.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:229/255.0 alpha:1.0];
  return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return section == 0 ? (_messageModel ? _messageModel.height : 0): kSectionHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  JHActionSheetModel * model;
  if (indexPath.section == 1) {
    model = self.cancelModel;
    HandleBlock block = model.handleBlock;
    if (block) {
      block(self.cancelButtonIndex);
    }
  } else {
    model = self.otherModels[indexPath.row];
    HandleBlock block = model.handleBlock;
    if (block) {
      block(indexPath.row);
    }
  }
  [self dismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self dismiss];
}

@end
