//
//  LimitFreeController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//
#import "LimitFreeViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "MainViewController.h"
#import "AppLog.h"

static LimitFreeViewController *g_LimitFreeViewController = nil;

@interface LimitFreeViewController ()

@end

@implementation LimitFreeViewController

#pragma mark - 构造,析构函数
- (id)init
{
    self = [super init];
    if (self) {
        g_LimitFreeViewController = self;
        //self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}

+(LimitFreeViewController *)getLimitFreeViewControllerInstence
{
    return g_LimitFreeViewController;
}

#pragma mark - loadView
-(void)loadView
{
    [super loadView];
    AppLogMessage(AppLogLevelInfo, @"---- LimitFreeViewController :: loadView ----");
    
    _limitFreeInfoViewController        = [[LimitFreeInfoViewController alloc]init];
    _appDetailInfoViewController        = [[AppDetailInfoViewController alloc]init];
    _appCategoryViewController          = [[AppCategoryViewController alloc]init];
    
    _detailInfoImageShowViewController  = [[DetailInfoImageShowViewController alloc]init];
    _limitFreeSearchViewController      = [[LimitFreeSearchViewController alloc]init];
    
    _navigationController = [[UINavigationController alloc]initWithRootViewController:_limitFreeInfoViewController];
    
    if ([UIDevice systemVersionFirstNumber] >= 7) {
        UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 100, 40)];
        titleView.text = @"限免分类";
        [titleView setTextColor:[UIColor whiteColor]];
        titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
        [titleView setTextAlignment:NSTextAlignmentCenter];
        [_appCategoryViewController.navigationItem setTitleView:titleView];
        [titleView release];

        [_navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:100/255.f green:220/255.f blue:50/255.f alpha:1]];
         _navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    else {
        _appCategoryViewController.navigationItem.title = @"限免分类";
        
        [_navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"顶部条背景.png"] forBarMetrics:UIBarMetricsDefault];
    }

    _navigationController.view.frame = self.view.bounds;
    [self.view addSubview:_navigationController.view];
}

#pragma mark - 显示分类页面
-(void)showAppCategoryViewController
{
    [_navigationController pushViewController:_appCategoryViewController animated:YES];
    _appCategoryViewController.categoryType = @"limit";
}

#pragma mark - 显示应用详情
-(void)showAppDetailInfoViewController:(NSString*)appId
{
    [_appDetailInfoViewController setAppId:appId];
    [_navigationController pushViewController:_appDetailInfoViewController animated:YES];
}

#pragma mark - 显示搜索结果页面
- (void)showLimitFreeSearchController:(NSString*)searchtext
{
    _limitFreeSearchViewController.searchtext = searchtext;
    [_navigationController pushViewController:_limitFreeSearchViewController animated:YES];
    [_limitFreeSearchViewController refreshData];
}

#pragma mark - 显示系统设置页面
-(void)showSettingViewController
{
    [[MainViewController shareMainViewController] showSettingViewController];
}

#pragma mark - 显示限免根视图
-(void)showRootViewController
{
    [_navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 显示应用详情中应用截图页面
-(void)showDetailInfoImageShowViewController:(NSArray*)photos :(NSUInteger)selectedImageId
{
    _navigationController.navigationBar.hidden = YES;
    _detailInfoImageShowViewController.detailInfoImageShowViewPhotos = photos;
    _detailInfoImageShowViewController.selectedImageId = selectedImageId;
    [_detailInfoImageShowViewController showDetailInfoImageShowView];
    [_navigationController pushViewController:_detailInfoImageShowViewController animated:NO];
    [UIView transitionWithView:_navigationController.view duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 关闭应用详情中应用截图页面
-(void)closeDetailInfoImageShowViewController
{
    _navigationController.navigationBar.hidden = NO;
    [_navigationController popViewControllerAnimated:NO];
    [_detailInfoImageShowViewController removeDetailInfoImageShowView];
    
    [UIView transitionWithView:_navigationController.view duration:0.8 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 根据选中的应用分类显示该类型的应用列表
-(void)showAppListFromAppCategoryViewController:(NSString*)titleText CategoryId:(NSUInteger)categoryId
{
    _limitFreeInfoViewController.navigationItemTitleText = titleText;  //根据选中的分类设置导航视图控制器标题
    _limitFreeInfoViewController.categoryId = categoryId;   
    [_navigationController popToViewController:_limitFreeInfoViewController animated:YES];
    [_limitFreeInfoViewController refreshData];
}

#pragma mark - 显示选中的某个附近的app详情页面
-(void)showPlaceAppDetailInfo:(NSString*)appId
{
    AppDetailInfoViewController *appDetailInfoViewController = [[AppDetailInfoViewController alloc]init];
    [appDetailInfoViewController setAppId:appId];
    [_navigationController pushViewController:appDetailInfoViewController animated:YES];
    [appDetailInfoViewController release];
}

#pragma mark - 析构函数
-(void)dealloc
{
    [self MY_viewDidUnLoad];
    [super dealloc];
}

- (void)MY_viewDidUnLoad
{
    AppLogMessage(AppLogLevelInfo, @"---- LimitFreeViewController :: MY_viewDidUnLoad ----");
    
    [_detailInfoImageShowViewController release];
    _detailInfoImageShowViewController = nil;
    [_limitFreeInfoViewController release];
    _limitFreeInfoViewController = nil;
    [_limitFreeSearchViewController release];
    _limitFreeSearchViewController = nil;
    [_appDetailInfoViewController release];
    _appDetailInfoViewController = nil;
    [_appCategoryViewController release];
    _appCategoryViewController = nil;
    [_navigationController release];
    _navigationController = nil;
    self.view = nil;
}
@end
