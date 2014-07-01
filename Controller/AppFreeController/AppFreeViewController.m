//
//  AppFreeViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-22.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppFreeViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "MainViewController.h"
#import "AppLog.h"

@interface AppFreeViewController ()

@end

static AppFreeViewController* g_AppFreeViewController = nil;
@implementation AppFreeViewController

#pragma mark - AppFreeViewController 单例
+(AppFreeViewController*)shareAppFreeViewController
{
    return g_AppFreeViewController;
}

- (id)init
{
    self = [super init];
    if (self) {
        g_AppFreeViewController = self;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    AppLogMessage(AppLogLevelInfo, @"---- AppFreeViewController :: loadView ----");
    _appFreeInfoViewController          = [[AppFreeInfoViewController alloc]init];
    _appCategoryViewController          = [[AppCategoryViewController alloc]init];
    _appDetailInfoViewController        = [[AppDetailInfoViewController alloc]init];
    _detailInfoImageShowViewController  = [[DetailInfoImageShowViewController alloc]init];
    _appFreeSearchViewController        = [[AppFreeSearchViewController alloc]init];
    
    _navigationController = [[UINavigationController alloc]initWithRootViewController:_appFreeInfoViewController];
    _appFreeInfoViewController.view.frame = self.view.bounds;
    [self.view addSubview:_navigationController.view];
    
    if ([UIDevice systemVersionFirstNumber] >= 7) {
        UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 100, 40)];
        titleView.text = @"免费分类";
        [titleView setTextColor:[UIColor whiteColor]];
        titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
        [titleView setTextAlignment:NSTextAlignmentCenter];
        [_appCategoryViewController.navigationItem setTitleView:titleView];
        [titleView release];
        
        [_navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:100/255.f green:220/255.f blue:50/255.f alpha:1]];
        _navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    else
    {
        _appCategoryViewController.navigationItem.title = @"免费分类";
        
        [_navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"顶部条背景.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - 显示系统设置页
-(void)showSettingViewController
{
    [[MainViewController shareMainViewController] showSettingViewController];
}

#pragma mark - 显示应用分类页
-(void)showAppCategoryViewController
{
    [_navigationController pushViewController:_appCategoryViewController animated:YES];
    _appCategoryViewController.categoryType = @"free";
}

#pragma mark - 显示应用详情页
-(void)showAppDetailInfoViewController:(NSString*)appId
{
    [_appDetailInfoViewController setAppId:appId];
    [_navigationController pushViewController:_appDetailInfoViewController animated:YES];
}

#pragma mark - 显示应用截图展示页
-(void)showDetailInfoImageShowViewController:(NSArray*)photos :(NSUInteger)selectedImageId
{
    _navigationController.navigationBar.hidden = YES;   //显示应用截图时隐藏导航条
    _detailInfoImageShowViewController.detailInfoImageShowViewPhotos = photos;
    _detailInfoImageShowViewController.selectedImageId = selectedImageId;
    [_detailInfoImageShowViewController showDetailInfoImageShowView];
    [_navigationController pushViewController:_detailInfoImageShowViewController animated:NO];
    [UIView transitionWithView:_navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - 关闭应用截图展示页
-(void)closeDetailInfoImageShowViewController
{
    _navigationController.navigationBar.hidden = NO;
    [_navigationController popViewControllerAnimated:NO];
    [_detailInfoImageShowViewController removeDetailInfoImageShowView];
    [UIView transitionWithView:_navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 根据用户选择的分类显示应用列表
-(void)showAppListFromAppCategoryViewController:(NSString*)titleText CategoryId:(NSUInteger)categoryId
{   
    _appFreeInfoViewController.navigationItemTitleText = titleText;
    _appFreeInfoViewController.categoryId = categoryId;
    [_navigationController popToViewController:_appFreeInfoViewController animated:YES];
    [_appFreeInfoViewController refreshData];
}

#pragma mark - 显示搜索结果页
- (void)showAppFreeSearchController:(NSString*)searchtext
{
    _appFreeSearchViewController.searchtext = searchtext;
    [_navigationController pushViewController:_appFreeSearchViewController animated:YES];
    [_appFreeSearchViewController refreshData ];
}

-(void)showPlaceAppDetailInfo:(NSString*)appId
{
    AppDetailInfoViewController *appDetailInfoViewController = [[AppDetailInfoViewController alloc]init];
    [appDetailInfoViewController setAppId:appId];
    [_navigationController pushViewController:appDetailInfoViewController animated:YES];
    [appDetailInfoViewController release];
}

- (void)showRootViewController
{
    [_navigationController popToRootViewControllerAnimated:YES];
}

- (void)MY_viewDidUnLoad
{
    AppLogMessage(AppLogLevelInfo, @"---- AppFreeViewController :: MY_viewDidUnLoad ----");
    
    [_appFreeSearchViewController release];
    _appFreeSearchViewController = nil;
    [_detailInfoImageShowViewController release];
    _detailInfoImageShowViewController = nil;
    [_appDetailInfoViewController release];
    _appDetailInfoViewController = nil;
    [_navigationController release];
    _navigationController = nil;
    [_appFreeInfoViewController release];
    _appFreeInfoViewController = nil;
    [_appCategoryViewController release];
    _appCategoryViewController = nil;
    self.view = nil;
}

- (void)dealloc
{
    [self MY_viewDidUnLoad];
    [super dealloc];
}
@end
