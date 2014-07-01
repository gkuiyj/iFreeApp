//
//  AppSubjectController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppSubjectViewController.h"
#import "AppLog.h"
#import "UIDevice+UIDeviceCategory.h"

static AppSubjectViewController *g_appSubjectViewController = nil;

@interface AppSubjectViewController ()

@end

@implementation AppSubjectViewController

- (id)init
{
    self = [super init];
    if (self) {
        g_appSubjectViewController = self;
    }
    return self;
}

+(AppSubjectViewController*)shareAppSubjectViewController
{
    return g_appSubjectViewController;
}

- (void)loadView
{
    [super loadView];
    AppLogMessage(AppLogLevelInfo, @"---- AppSubjectViewController :: loadView ----");
    
    _appSubjecInfoViewController = [[AppSubjecInfoViewController alloc]init];
    _appDetailInfoViewController = [[AppDetailInfoViewController alloc]init];
    _detailInfoImageShowViewController = [[DetailInfoImageShowViewController alloc]init];
    
    _navigationController = [[UINavigationController alloc]initWithRootViewController:_appSubjecInfoViewController];
    _navigationController.view.frame = self.view.bounds;
    [self.view addSubview:_navigationController.view];
    
    if ([UIDevice systemVersionFirstNumber] >= 7) {
        UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 100, 40)];
        titleView.text = @"专题";
        [titleView setTextColor:[UIColor whiteColor]];
        titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
        [titleView setTextAlignment:NSTextAlignmentCenter];
        [_appSubjecInfoViewController.navigationItem setTitleView:titleView];
        [titleView release];
        
        [_navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:100/255.f green:220/255.f blue:50/255.f alpha:1]];
        _navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    else
    {
        _appSubjecInfoViewController.navigationItem.title = @"专题";
        
        [_navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"顶部条背景.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - 跳转到详情视图
-(void)showAppDetailInfoViewController:(NSString*)appId
{
    _appDetailInfoViewController.appId = appId;
    [_navigationController pushViewController:_appDetailInfoViewController animated:YES];
}

#pragma mark - 跳转到应用截图展示视图
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

#pragma mark - 关闭应用截图展示视图
-(void)closeDetailInfoImageShowViewController
{
    _navigationController.navigationBar.hidden = NO;
    [_navigationController popViewControllerAnimated:NO];
    [_detailInfoImageShowViewController removeDetailInfoImageShowView];
    [UIView transitionWithView:_navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showPlaceAppDetailInfo:(NSString*)appId
{
    AppDetailInfoViewController *appDetailInfoViewController = [[AppDetailInfoViewController alloc]init];
    [appDetailInfoViewController setAppId:appId];
    [_navigationController pushViewController:appDetailInfoViewController animated:YES];
    [appDetailInfoViewController release];
}

-(void)showRootViewController
{
    [_navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc
{
    [self MY_viewDidUnLoad];
    [super dealloc];
}

- (void)MY_viewDidUnLoad
{
    AppLogMessage(AppLogLevelInfo, @"---- AppSubjectViewController :: MY_viewDidUnLoad ----");

    [_appDetailInfoViewController release];
    _appDetailInfoViewController = nil;
    [_appSubjecInfoViewController release];
    _appSubjecInfoViewController = nil;
    [_navigationController release];
    _navigationController = nil;
    [_detailInfoImageShowViewController release];
    _detailInfoImageShowViewController = nil;
    self.view = nil;
}
@end
