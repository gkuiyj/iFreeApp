//
//  AppFreeSearchViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppFreeSearchViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "AppFreeViewController.h"

@interface AppFreeSearchViewController ()

@end

@implementation AppFreeSearchViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //根据不用系统版本设置是否显示全屏（设置视图高度时，导航条高度是否计算）
    if ([UIDevice systemVersionFirstNumber] < 7)
    {
        self.wantsFullScreenLayout = NO;
    }
    else
    {
        self.edgesForExtendedLayout = UIRectEdgeBottom|UIRectEdgeLeft | UIRectEdgeRight;  //不计算顶部
    }
    _appFreeView = [[AppFreeView alloc] initWithFrame:self.view.bounds];
    _appFreeModel = [[AppFreeModel alloc] init];
    _appFreeView.dataSource = _appFreeModel;
    _appFreeView.delegate = self;
    _appFreeView.tableView.tableHeaderView = nil;
    self.view = _appFreeView;
    
    [self refreshData];
}

- (void)refreshData
{
    //刷新数据，并传入搜索条件
    _appFreeModel.searchtext = _searchtext;
    [_appFreeModel prepareAppFreeModelData:^(BOOL finished) {
        if (finished)
        {
            [_appFreeView reloadData];
        }
    }];
}

//显示应用详情
- (void)showAppDetailInfoViewController:(NSInteger)rowIndex
{
    AppFreeModel *model =  _appFreeModel.appFreeArray[rowIndex];
    [[AppFreeViewController shareAppFreeViewController] showAppDetailInfoViewController:model.appId];
}

- (void)dealloc
{
    [_appFreeModel release];
    _appFreeModel = nil;
    [_appFreeView release];
    _appFreeView = nil;
    [_searchtext release];
    _searchtext = nil;
    [super dealloc];
}
@end
