//
//  AppSubjectView.m
//  iFreeApp
//
//  Created by wangkai on 14-5-21.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppSubjectView.h"

@implementation AppSubjectView

@dynamic dataSource;

- (void)setDataSource:(id<WKTableViewDataSource>)dataSource
{
    _tableView.dataSource = dataSource;
}

- (id<WKTableViewDataSource>)dataSource
{
    return _tableView.dataSource;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[WKTableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return self;
}

- (void)layoutSubviews
{
    _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-40);
}

#pragma mark - tableView delegate 的 函数
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 340;
}

#pragma mark - 刷新数据
- (void)reloadData
{
    [_tableView reloadData];
}

- (void)dealloc
{
    [_tableView release];
    _tableView = nil;
    [super dealloc];
}
@end
