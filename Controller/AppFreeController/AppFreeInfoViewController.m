//
//  AppFreeInfoViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-22.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppFreeInfoViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "AppFreeViewController.h"

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

-(void)rightBarButtonClick:(id)sender
{
    [[AppFreeViewController shareAppFreeViewController] showAppCategoryViewController];
}

-(void)leftBarButtonClick:(id)sender
{
    [[AppFreeViewController shareAppFreeViewController] showSettingViewController];
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
    _appFreeView = [[AppFreeView alloc]init];
    _appFreeView.delegate = self;
    _appFreeModel = [[AppFreeModel alloc]init];
    _appFreeView.dataSource = _appFreeModel;
    self.view = _appFreeView;
    
    [self refreshData];
}

//设置导航条标题
-(void)setNavigationItemTitleText:(NSString *)navigationItemTitleText
{
    if ([UIDevice systemVersionFirstNumber] >= 7)
    {
        _titleView.text = navigationItemTitleText;
    }
    else
    {
        self.navigationItem.title = _navigationItemTitleText;
    }
}

-(void)refreshData
{
    [self showDataLoadingDialog];
    //刷新数据
    _appFreeModel.searchByCategoryId = _categoryId;
    [_appFreeModel prepareAppFreeModelData:^(BOOL finished) {
        if (finished)
        {
            closeModalView();
            [_appFreeView reloadData];
        }
        else
        {
            closeModalView();
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"网络超时！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlertView:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert",nil] repeats:NO];
            [alertView release];
        }
    }];
}

- (void)dismissAlertView:(NSTimer *)timer
{
    UIAlertView *alert = [[timer userInfo]  objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

//显示应用详情
-(void)showAppDetailInfoViewController:(NSInteger)rowIndex
{
    AppFreeModel *model =  _appFreeModel.appFreeArray[rowIndex];
    
    [[AppFreeViewController shareAppFreeViewController] showAppDetailInfoViewController:model.appId];
}

//显示搜索结果
- (void)showAppFreeSearchController:(NSString*)searchtext
{
    [[AppFreeViewController shareAppFreeViewController] showAppFreeSearchController:searchtext];
}

#pragma mark - 显示数据正在加载对话框(模态)
- (void)showDataLoadingDialog
{
    _dataLoadingDialog = [[DataLoadingDialog alloc]initWithFrame:CGRectMake(0 , 0, 200, 150)];
    _dataLoadingDialog.center = CGPointMake(160, 240);
    _dataLoadingDialog.text = @"正在努力加载中···";
    _dataLoadingDialog.delegate = self;
    
    [_dataLoadingDialog startActivity];
    
    showModalView(_dataLoadingDialog,5);
    
    [_dataLoadingDialog release];
}

- (void)DataLoadingDialogDidCancel:(DataLoadingDialog *)dataLoadingDialog
{
    closeModalView();
}
@end
