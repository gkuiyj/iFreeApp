//
//  LimitFreeSearchViewController.m
//  iFreeApp
//
//  Created by qianfeng on 14-6-7.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "LimitFreeSearchViewController.h"
#import "LimitFreeTableViewCell.h"
#import "LimitFreeViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "AppLog.h"

@interface LimitFreeSearchViewController ()

@end

@implementation LimitFreeSearchViewController

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    if ([UIDevice systemVersionFirstNumber] < 7)
    {
        self.wantsFullScreenLayout = NO;
    }
    else
    {
        self.edgesForExtendedLayout = UIRectEdgeBottom|UIRectEdgeLeft | UIRectEdgeRight;
    }
    _limitFreeView = [[LimitFreeView alloc] initWithFrame:self.view.bounds];
    _limitFreeModel = [[LimitFreeModel alloc] init];
    _limitFreeView.dataSource = _limitFreeModel;
    _limitFreeView.delegate = self;
    _limitFreeView.tableView.tableHeaderView = nil;
    self.view = _limitFreeView;
    
    //第一次加载视图时刷新数据
    [self refreshData];
    
}

-(void)dealloc
{
    [_searchtext release];
    _searchtext = nil;
    
    [_limitFreeView release];
    _limitFreeView = nil;
    [_limitFreeModel release];
    _limitFreeModel = nil;
    [super dealloc];
}

- (void)refreshData
{
    //刷新数据，并传入搜索条件
    _limitFreeModel.searchtext = _searchtext;
    [_limitFreeModel prepareLimitFreeModelData:^(BOOL finished) {
        if (finished)
        {
            [_limitFreeView reloadData];
        }
    }];
}

//显示应用详情
- (void)showAppDetailInfoViewController:(NSInteger)rowIndex
{
    LimitFreeModel *model =  _limitFreeModel.limitFreeArray[rowIndex];
    [[LimitFreeViewController getLimitFreeViewControllerInstence] showAppDetailInfoViewController:model.appId];
}
@end
