//
//  MainViewController.m
//  testiOS_base
//
//  Created by wangkai on 14-4-30.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "MainViewController.h"
#import "UIDevice+UIDeviceCategory.h"

@interface MainViewController ()

@end
static MainViewController *g_mainViewController = nil;
@implementation MainViewController

- (id)init
{
    self = [super init];
    if (self) {
        g_mainViewController = self;
    }
    return self;
}

+(MainViewController*)shareMainViewController
{
    return g_mainViewController;
}

-(void)loadView
{
    [super loadView];
    
    _appFreeViewController = [[AppFreeViewController alloc]init];
    _reducePriceViewController = [[ReducePriceViewController alloc]init];
    _limitFreeViewController = [[LimitFreeViewController alloc]init];
    _appSubjectViewController = [[AppSubjectViewController alloc]init];
    _appRankViewController = [[AppRankViewController alloc]init];
    
    _settingViewController = [[SettingViewController alloc]init];
    
    _tabBarController = [[UITabBarController alloc]init];
    _tabBarController.viewControllers = [NSArray arrayWithObjects:_limitFreeViewController,_reducePriceViewController,_appFreeViewController,_appSubjectViewController,_appRankViewController, nil];
    
    if ([UIDevice systemVersionFirstNumber] >= 7) {
        _limitFreeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"限免" image:[UIImage imageNamed:@"btn_限免_正常.png"]
                                                                selectedImage:[UIImage imageNamed:@"btn_限免_点击.png"]];
        _appRankViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"热榜" image:[UIImage imageNamed:@"btn_热点_正常.png"] selectedImage:[UIImage imageNamed:@"btn_热点_点击.png"]];
        _appSubjectViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"专题" image:[UIImage imageNamed:@"btn_专题_正常.png"] selectedImage:[UIImage imageNamed:@"btn_专题_点击.png"]];
        _appFreeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"免费" image:[UIImage imageNamed:@"btn_免费_正常.png"] selectedImage:[UIImage imageNamed:@"btn_免费_点击.png"]];
        _reducePriceViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"降价" image:[UIImage imageNamed:@"btn_降价_正常.png"] selectedImage:[UIImage imageNamed:@"btn_降价_点击.png"]];
        
        
        _tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
        //设置UITabBar选中后的背景颜色
        [_tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.4 green:200/255.f blue:50/255.f alpha:1]];
        
        //设置UITabBarItem选中后 字体的颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:100/255.f green:220/255.f blue:83/255.f alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        //设置UITabBarItem字体的类型 大小,未选中时颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1],NSFontAttributeName:[UIFont fontWithName:@"Arial Rounded MT Bold" size:13]} forState:UIControlStateNormal];
    }
    else
    {
        _limitFreeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"限免" image:[UIImage imageNamed:@"btn_限免_正常.png"] tag:1];
        _limitFreeViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_限免_点击.png"];
        
        _appRankViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"热榜" image:[UIImage imageNamed:@"btn_热点_正常.png"] tag:2];
        _appRankViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_热点_点击.png"];
        _appSubjectViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"专题" image:[UIImage imageNamed:@"btn_专题_正常.png"] tag:3];
        _appSubjectViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_专题_点击.png"];
        _appFreeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"免费" image:[UIImage imageNamed:@"btn_免费_正常.png"] tag:4];
        _appFreeViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_免费_点击.png"];
        _reducePriceViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"降价" image:[UIImage imageNamed:@"btn_降价_正常.png"] tag:5];
        _reducePriceViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_降价_点击.png"];
        
        
        [_tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"底部条.png"]];
    }
    
    [self.view addSubview:_tabBarController.view];
}

-(void)showSettingViewController
{
    [self presentViewController:_settingViewController animated:YES completion:^{
        
    }];
}

-(void)showBackViewController
{
    [_settingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)showDetailInfoImageShowViewController:(NSArray*)photos :(NSUInteger)selectedImageId
{
    _tabBarController.tabBar.hidden = YES;
    NSUInteger index = [_tabBarController selectedIndex];
    
    if (index == 0)
    {
        [_limitFreeViewController showDetailInfoImageShowViewController:photos :selectedImageId];

    }
    else if (index == 1)
    {
        [_reducePriceViewController showDetailInfoImageShowViewController:photos :selectedImageId];
    }
    else if (index == 2)
    {
        [_appFreeViewController showDetailInfoImageShowViewController:photos :selectedImageId];
    }
    else if (index == 3)
    {
        [_appSubjectViewController showDetailInfoImageShowViewController:photos :selectedImageId];
    }
    else if (index == 4)
    {
        [_appRankViewController showDetailInfoImageShowViewController:photos :selectedImageId];
    }
}

-(void)closeDetailInfoImageShowViewController
{
    _tabBarController.tabBar.hidden = NO;
    NSUInteger index = [_tabBarController selectedIndex];
    if (index == 0)
    {
        [_limitFreeViewController closeDetailInfoImageShowViewController];
    }
    else if (index == 1)
    {
        [_reducePriceViewController closeDetailInfoImageShowViewController];
    }
    else if (index == 2)
    {
        [_appFreeViewController closeDetailInfoImageShowViewController];
    }
    else if (index == 3)
    {
        [_appSubjectViewController closeDetailInfoImageShowViewController];
    }
    else if (index == 4)
    {
        [_appRankViewController closeDetailInfoImageShowViewController];
    }
}


-(void)showPlaceAppDetailInfo:(NSString*)appId
{
    NSUInteger index = [_tabBarController selectedIndex];
    if (index == 0)
    {
        [_limitFreeViewController showPlaceAppDetailInfo:appId];
    }
    else if (index == 1)
    {
        [_reducePriceViewController showPlaceAppDetailInfo:appId];
    }
    else if (index == 2)
    {
        [_appFreeViewController showPlaceAppDetailInfo:appId];
    }
    else if (index == 3)
    {
        [_appSubjectViewController showPlaceAppDetailInfo:appId];
    }
    else if (index == 4)
    {
        [_appRankViewController showPlaceAppDetailInfo:appId];
    }
}

- (void)showRootViewControllerFromPlaceAppDetailInfo
{
    NSUInteger index = [_tabBarController selectedIndex];
    if (index == 0)
    {
        [_limitFreeViewController showRootViewController];
    }
    else if (index == 1)
    {
        [_reducePriceViewController showRootViewController];
    }
    else if (index == 3)
    {
        [_appSubjectViewController showRootViewController];
    }
    else if (index == 2)
    {
        [_appFreeViewController showRootViewController];
    }
    else if (index == 4)
    {
        [_appRankViewController showRootViewController];
    }
}


-(void)showAppListFromAppCategoryViewController:(NSString*)titleText CategoryId:(NSUInteger)categoryId
{
    
    NSUInteger index = [_tabBarController selectedIndex];
    NSMutableString *string = nil;
    if (index == 0)
    {
        if (titleText == nil) {
            string = [NSMutableString stringWithFormat:@"限免"];
        }else
        {
            string = [NSMutableString stringWithFormat:@"限免-%@类",titleText];
        }
        [_limitFreeViewController showAppListFromAppCategoryViewController:string CategoryId:categoryId];
        
    }
    else if (index == 1)
    {
        if (titleText == nil) {
            string = [NSMutableString stringWithFormat:@"降价"];
        }else
        {
            string = [NSMutableString stringWithFormat:@"降价-%@类",titleText];
        }
        [_reducePriceViewController showAppListFromAppCategoryViewController:string CategoryId:categoryId];
    }
    else if (index == 2)
    {
        if (titleText == nil) {
            string = [NSMutableString stringWithFormat:@"免费"];
        }else
        {
            string = [NSMutableString stringWithFormat:@"免费-%@类",titleText];
        }
        [_appFreeViewController showAppListFromAppCategoryViewController:string CategoryId:categoryId];
    }
    else if (index == 4)
    {
        if (titleText == nil) {
            string = [NSMutableString stringWithFormat:@"热榜"];
        }else
        {
            string = [NSMutableString stringWithFormat:@"热榜-%@类",titleText];
        }
        [_appRankViewController showAppListFromAppCategoryViewController:string CategoryId:categoryId];
    }
}

#pragma mark - 处理内存警告
- (void)didReceiveMemoryWarning
{
    NSLog(@"MainViewController didReceiveMemoryWarning");
    
    NSUInteger index = [_tabBarController selectedIndex];
    if (index == 0)
    {
        [_reducePriceViewController MY_viewDidUnLoad];
        [_appFreeViewController MY_viewDidUnLoad];
        [_appSubjectViewController MY_viewDidUnLoad];
        [_appRankViewController MY_viewDidUnLoad];
    }
    else if (index == 1)
    {
        [_limitFreeViewController MY_viewDidUnLoad];
        [_appFreeViewController MY_viewDidUnLoad];
        [_appSubjectViewController MY_viewDidUnLoad];
        [_appRankViewController MY_viewDidUnLoad];
    }
    else if (index == 2)
    {
        [_limitFreeViewController MY_viewDidUnLoad];
        [_reducePriceViewController MY_viewDidUnLoad];
        [_appSubjectViewController MY_viewDidUnLoad];
        [_appRankViewController MY_viewDidUnLoad];
    }
    else if (index == 3)
    {
        [_limitFreeViewController MY_viewDidUnLoad];
        [_reducePriceViewController MY_viewDidUnLoad];
        [_appFreeViewController MY_viewDidUnLoad];
        [_appRankViewController MY_viewDidUnLoad];
    }
    else if (index == 4)
    {
        [_limitFreeViewController MY_viewDidUnLoad];
        [_reducePriceViewController MY_viewDidUnLoad];
        [_appFreeViewController MY_viewDidUnLoad];
        [_appSubjectViewController MY_viewDidUnLoad];
    }
}

-(void)dealloc
{
    [_settingViewController release];
    _settingViewController = nil;
    [_appFreeViewController release];
    _appFreeViewController = nil;
    [_reducePriceViewController release];
    _reducePriceViewController = nil;
    [_limitFreeViewController release];
    _limitFreeViewController = nil;
    [_appSubjectViewController release];
    _appSubjectViewController = nil;
    [_appRankViewController release];
    _appRankViewController = nil;
    [_tabBarController release];
    _tabBarController = nil;
    [super dealloc];
}

@end
