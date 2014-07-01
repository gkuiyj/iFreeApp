//
//  WKSearchDisplayController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-10.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "ReducePriceSearchController.h"
#import "ReducePriceInfoCell.h"
#import "ReducePriceViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "AppLog.h"

@implementation ReducePriceSearchController

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
    _reducePriceInfoView = [[ReducePriceInfoView alloc] initWithFrame:self.view.bounds];
    _reducePriceModel = [[ReducePriceModel alloc] init];
    _reducePriceInfoView.dataSource = _reducePriceModel;
    _reducePriceInfoView.delegate = self;
    _reducePriceInfoView.tableView.tableHeaderView = nil;
    self.view = _reducePriceInfoView;
    
    //第一次加载视图时刷新数据
    [self refreshData];

}

-(void)dealloc
{
    [_searchtext release];
    _searchtext = nil;

    [_reducePriceInfoView release];
    _reducePriceInfoView = nil;
    [_reducePriceModel release];
    _reducePriceModel = nil;
    [super dealloc];
}

- (void)refreshData
{
    //刷新数据，并传入搜索条件
    _reducePriceModel.searchtext = _searchtext;
    [_reducePriceModel prepareReducePriceModelData:^(BOOL finished) {
        if (finished)
        {
            [_reducePriceInfoView reloadData];
        }
    }];
}

//显示应用详情
- (void)showAppDetailInfoViewController:(NSInteger)rowIndex
{
    ReducePriceModel *model =  _reducePriceModel.reducePriceArray[rowIndex];
    [[ReducePriceViewController shareReducePriceViewController] showAppDetailInfoViewController:model.appId];
}

@end
