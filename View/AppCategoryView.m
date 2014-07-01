//
//  AppCategoryView.m
//  iFreeApp
//
//  Created by wangkai on 14-5-18.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppCategoryView.h"
#import "AppCategoryViewController.h"

@implementation AppCategoryView

#pragma mark - 属性

@dynamic dataSource;

- (void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    _tableView.dataSource = dataSource;
}

- (id<UITableViewDataSource>)dataSource
{
    return _tableView.dataSource;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-48) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        
        [self addSubview:_tableView];
    }
    return self;
}

#pragma mark - Layout 
- (void)layoutSubviews
{
    _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-48);
}

#pragma mark - 刷新数据
- (void)reloadData
{
    [_tableView reloadData];
}

#pragma mark - tableView delegate 的 函数
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate showAppListFromAppCategoryViewController:indexPath.row];
}

- (void)dealloc
{
    [_tableView release];
    _tableView = nil;
    [super dealloc];
}
@end
