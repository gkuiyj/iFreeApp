//
//  AppDetailInfoViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-7.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppDetailInfoViewController.h"
#import "DetailInfoImageShowViewController.h"
#import "MainViewController.h"
#import "AppLog.h"

@interface AppDetailInfoViewController ()

@end

static AppDetailInfoViewController *g_appDetailInfoViewController;
@implementation AppDetailInfoViewController

+ (AppDetailInfoViewController*)shareAppDetailInfoViewController
{
    return  g_appDetailInfoViewController;
}

#pragma mark - 初始化
- (id)init
{
    self = [super init];
    if (self)
    {
        float sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (sysVersion >= 7.0)
        {
            UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 100, 40)];
            titleView.text = @"应用详情";
            [titleView setTextColor:[UIColor whiteColor]];
            titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
            [titleView setTextAlignment:NSTextAlignmentCenter];
            [self.navigationItem setTitleView:titleView];
            [titleView release];
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonItemClick:)];
            self.navigationItem.rightBarButtonItem = barButtonItem;
        }
        else
        {
            self.navigationItem.title = @"应用详情";
        }
        
        _appDetailInfoModel = [[AppDetailInfoModel alloc]init];
        
        g_appDetailInfoViewController = self;
    }
    return self;
}

#pragma mark - 点击首页按钮
- (void)barButtonItemClick:(id)sender
{
    [[MainViewController shareMainViewController] showRootViewControllerFromPlaceAppDetailInfo];
}

#pragma mark - 加载视图
-(void)loadView
{
    [super loadView];
    _appDetailInfoView = [[AppDetailInfoView alloc]init];
    _appDetailInfoView.backgroundColor = [UIColor whiteColor];
    _appDetailInfoView.delegate = self;
    self.view = _appDetailInfoView;
    //[self refreshData];
    AppLogMessage(AppLogLevelInfo, @"---- AppDetailInfoViewController :: loadView ---- AppId = %@",_appId);
}

#pragma mark - getter/setter
-(void)setAppId:(NSString *)appId
{
    [appId retain];
    [_appId release];
    _appId = [appId copy];
    //[appId release];
    if (![_appDetailInfoModel.appId isEqualToString:appId])
    {
        [self refreshData];
    }
}

#pragma mark - 刷新ui数据
- (void)refreshData
{
    [self showDataLoadingDialog];
    [_appDetailInfoModel prepareAppPlaceData];
    //刷新数据
    [_appDetailInfoModel prepareAppDetailInfoModelData:_appId :^(BOOL finished)
    {
        if (finished)
        {
            [_appDetailInfoView fillData:_appDetailInfoModel];
            closeModalView();
        }
        else
        {
            closeModalView();
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的网络不给力！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

#pragma mark - 显示截图页面
- (void)showImageShowView:(NSUInteger)selectedImageId
{
    [[MainViewController shareMainViewController] showDetailInfoImageShowViewController:_appDetailInfoModel.photos :selectedImageId];
}

#pragma mark - 显示选中的某个附近正在使用的app
- (void)showPalceAppDetailInfo:(NSString*)appId
{
    [[MainViewController shareMainViewController] showPlaceAppDetailInfo:appId];
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

-(void)dealloc
{
    [_appDetailInfoView release];
    _appDetailInfoView = nil;
    [_appDetailInfoModel release];
    _appDetailInfoModel = nil;
    [super dealloc];
}

@end
