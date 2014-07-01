//
//  LimitFreeView.m
//  iFreeApp
//
//  Created by wangkai on 14-6-7.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "LimitFreeView.h"

@implementation LimitFreeView

#pragma mark - 属性
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
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        _searchBar.showsCancelButton = NO;
        _searchBar.placeholder = @"请输入应用名称:";
        _searchBar.delegate = self;
        
        _tableView = [[WKTableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.tableHeaderView = _searchBar;
        
        _tableView.delegate = self;
        
        [self addSubview:_tableView];
    }
    return self;
}

- (void)layoutSubviews
{
    _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - tableView delegate 的 函数
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//选中某行时跳转到应用详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate showAppDetailInfoViewController:indexPath.row];
}

#pragma mark - 搜索框 delegate 的函数
//搜索框将要开始编辑时
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
//搜索按钮被点击时
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    NSString *searchString = [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_delegate showLimitFreeSearchController:searchString];
}
//取消搜索按钮被点击时
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

#pragma mark - 刷新数据
- (void)reloadData
{
    [_tableView reloadData];
}

- (void)dealloc
{
    [_searchBar release];
    _searchBar = nil;
    
    [_tableView release];
    _tableView = nil;
    
    [super dealloc];
}
@end
