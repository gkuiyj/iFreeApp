//
//  ReducePriceController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "ReducePriceViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "MainViewController.h"
#import "AppLog.h"

@interface ReducePriceViewController ()

@end
static ReducePriceViewController *g_ReducePriceViewController = nil;
@implementation ReducePriceViewController

+(ReducePriceViewController *)shareReducePriceViewController
{
    return g_ReducePriceViewController;
}

- (id)init
{
    self = [super init];
    if (self) {
        g_ReducePriceViewController = self;
    }
    return self;
}

- (void)dealloc
{
    [self MY_viewDidUnLoad];
    [super dealloc];
}

- (void)MY_viewDidUnLoad
{
    AppLogMessage(AppLogLevelInfo, @"---- ReducePriceViewController :: MY_viewDidUnLoad ----");
    
    [_reducePriceSearchController release];
    _reducePriceSearchController = nil;
    [_detailInfoImageShowViewController release];
    _detailInfoImageShowViewController = nil;
    [_appDetailInfoViewController release];
    _appDetailInfoViewController = nil;
    [_navigationController release];
    _navigationController = nil;
    [_reducePriceInfoViewController release];
    _reducePriceInfoViewController = nil;
    [_appCategoryViewController release];
    _appCategoryViewController = nil;
    self.view = nil;
}

- (void)loadView
{
    [super loadView];
    AppLogMessage(AppLogLevelInfo, @"---- ReducePriceViewController :: loadView ----");
    
    _reducePriceInfoViewController      = [[ReducePriceInfoViewController alloc]init];
    _appDetailInfoViewController        = [[AppDetailInfoViewController alloc]init];
    _appCategoryViewController          = [[AppCategoryViewController alloc]init];
    
    _detailInfoImageShowViewController  = [[DetailInfoImageShowViewController alloc]init];
    _reducePriceSearchController        = [[ReducePriceSearchController alloc]init];
    
    _navigationController = [[UINavigationController alloc]initWithRootViewController:_reducePriceInfoViewController];
    _navigationController.view.frame = self.view.bounds;
    [self.view addSubview:_navigationController.view];
    
    if ([UIDevice systemVersionFirstNumber] >= 7) {
        UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 100, 40)];
        titleView.text = @"降价分类";
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
        _appCategoryViewController.navigationItem.title = @"降价分类";
        
        [_navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"顶部条背景.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

-(void)showAppCategoryViewController
{
    [_navigationController pushViewController:_appCategoryViewController animated:YES];
    _appCategoryViewController.categoryType = @"down";
}
-(void)showAppDetailInfoViewController:(NSString*)appId
{
    [_appDetailInfoViewController setAppId:appId];
    [_navigationController pushViewController:_appDetailInfoViewController animated:YES];
}
-(void)showSettingViewController
{
    [[MainViewController shareMainViewController] showSettingViewController];
}
-(void)showRootViewController
{
    [_navigationController popToRootViewControllerAnimated:YES];
}


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

-(void)closeDetailInfoImageShowViewController
{
    _navigationController.navigationBar.hidden = NO;
    [_navigationController popViewControllerAnimated:NO];
    [_detailInfoImageShowViewController removeDetailInfoImageShowView];
    [UIView transitionWithView:_navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showAppListFromAppCategoryViewController:(NSString*)titleText CategoryId:(NSUInteger)categoryId
{
    _reducePriceInfoViewController.navigationItemTitleText = titleText;
    _reducePriceInfoViewController.categoryId = categoryId;
    [_navigationController popToViewController:_reducePriceInfoViewController animated:YES];
    [_reducePriceInfoViewController refreshData];
}

- (void)showReducePriceSearchController:(NSString*)searchtext
{
    _reducePriceSearchController.searchtext = searchtext;
    [_navigationController pushViewController:_reducePriceSearchController animated:YES];
    [_reducePriceSearchController refreshData];
}

-(void)showPlaceAppDetailInfo:(NSString*)appId
{
    AppDetailInfoViewController *appDetailInfoViewController = [[AppDetailInfoViewController alloc]init];
    [appDetailInfoViewController setAppId:appId];
    [_navigationController pushViewController:appDetailInfoViewController animated:YES];
    [appDetailInfoViewController release];
}
@end
