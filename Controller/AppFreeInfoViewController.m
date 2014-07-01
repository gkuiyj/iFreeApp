//
//  AppFreeInfoViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-22.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppFreeInfoViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "AppFreeViewController.m"
#import "AppLog.h"

@interface AppFreeInfoViewController ()

@end

@implementation AppFreeInfoViewController

- (id)init
{
    self = [super init];
    if (self) {
        _navigationItemTitleText = @"免费";
        _categoryId = 0;  //初始化为0，表示查询全部类别
        if ([UIDevice systemVersionFirstNumber] >= 7) {
            _titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 100, 40)];
            _titleView.text = _navigationItemTitleText;
            [_titleView setTextColor:[UIColor whiteColor]];
            _titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
            [_titleView setTextAlignment:NSTextAlignmentCenter];
            [self.navigationItem setTitleView:_titleView];
            [_titleView release];
        }
        else
        {
            self.navigationItem.title = _navigationItemTitleText;
        }
        //设置导航视图顶部左右按钮的背景图片,样式 以及单击事件
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_分类_正常.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_设置_正常.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick:)];
    }
    return self;
}

-(void)setNavigationItemTitleText:(NSString *)navigationItemTitleText
{
    if ([UIDevice systemVersionFirstNumber] >= 7)
    {
        _titleView.text = navigationItemTitleText;
    }else
    {
        self.navigationItem.title = _navigationItemTitleText;
    }
}

-(void)rightBarButtonClick:(id)sender
{
    //[[AppFreeViewController shareAppFreeViewController] showAppCategoryViewController];
}

-(void)leftBarButtonClick:(id)sender
{
    //[[AppFreeViewController shareAppFreeViewController] showSettingViewController];
}

#pragma mark - 视图控制器的函数

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
    
    _appFreeView= [[AppFreeView alloc] initWithFrame:self.view.bounds];
    _appFreeView.delegate = self;
    _appFreeModel = [[AppFreeModel alloc] init];
    _appFreeView.dataSource = _appFreeModel;
    
    self.view = _appFreeView;
    
    //第一次加载视图时刷新数据
    [self refreshData];
    
    AppLogMessage(AppLogLevelInfo, @"---- 进入免费视图 ----");
}

- (void)refreshData
{
    //刷新数据
    _appFreeModel.searchByCategoryId = _categoryId;
    [_appFreeModel prepareAppFreeModelData:^(BOOL finished) {
        if (finished)
        {
            [_appFreeView reloadData];
        }
    }];
}

//显示应用详情
-(void)showAppDetailInfoViewController:(NSInteger)rowIndex
{
//    AppFreeModel *model =  _appFreeModel.appFreeArray[rowIndex];
//    
//    [[AppFreeViewController shareAppFreeViewController] showAppDetailInfoViewController:model.appId];
}


-(void)dealloc
{
    [_titleView release];
    _titleView = nil;
    [_navigationItemTitleText release];
    _navigationItemTitleText = nil;
    [_appFreeView release];
    _appFreeView = nil;
    [_appFreeModel release];
    _appFreeModel = nil;
    [super dealloc];
}

@end
