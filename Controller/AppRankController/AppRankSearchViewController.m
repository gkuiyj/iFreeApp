//
//  AppRankSearchViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppRankSearchViewController.h"
#import "AppRankViewController.h"
#import "UIDevice+UIDeviceCategory.h"

@interface AppRankSearchViewController ()

@end

@implementation AppRankSearchViewController

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
    _appRankView = [[AppRankView alloc] initWithFrame:self.view.bounds];
    _appRankModel = [[AppRankModel alloc] init];
    _appRankView.dataSource = _appRankModel;
    _appRankView.delegate = self;
    _appRankView.tableView.tableHeaderView = nil;
    self.view = _appRankView;
    
    [self refreshData];
}

- (void)refreshData
{
    //刷新数据，并传入搜索条件
    _appRankModel.searchtext = _searchtext;
    [_appRankModel prepareAppRankModelData:^(BOOL finished) {
        if (finished)
        {
            [_appRankView reloadData];
        }
    }];
}

//显示应用详情
- (void)showAppDetailInfoViewController:(NSInteger)rowIndex
{
    AppRankModel *model =  _appRankModel.appRankArray[rowIndex];
    [[AppRankViewController shareAppRankViewController] showAppDetailInfoViewController:model.appId];
}

- (void)dealloc
{
    [_appRankModel release];
    _appRankModel = nil;
    [_appRankView release];
    _appRankView = nil;
    [_searchtext release];
    _searchtext = nil;
    [super dealloc];
}

@end
