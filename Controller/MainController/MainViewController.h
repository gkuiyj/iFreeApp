//
//  MainViewController.h
//  testiOS_base
//
//  Created by wangkai on 14-4-30.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppFreeViewController.h"
#import "ReducePriceViewController.h"
#import "LimitFreeViewController.h"
#import "AppSubjectViewController.h"
#import "AppRankViewController.h"
#import "SettingViewController.h"
#import "AppCategoryViewController.h"


/**
 *  主视图控制器(标签控制器) 管理系统中五个标签控制器,并设置标签按钮的样式
 */
@interface MainViewController : UIViewController
{
    LimitFreeViewController     *_limitFreeViewController;      //限免标签页，通过一个导航视图管理相关视图页
    AppFreeViewController       *_appFreeViewController;        //免费
    ReducePriceViewController   *_reducePriceViewController;    //降价
    AppSubjectViewController    *_appSubjectViewController;     //专题
    AppRankViewController       *_appRankViewController;        //热榜
    
    UITabBarController          *_tabBarController;             //底部标签栏
    
    SettingViewController       *_settingViewController;        //设置页面
}

/**
 *  获得主视图控制器单例
 *
 *  @return 返回主视图控制器对象
 */
+(MainViewController*)shareMainViewController;

/**
 *  显示系统设置页面
 */
-(void)showSettingViewController;

/**
 *  返回上一个视图控制器
 */
-(void)showBackViewController;

/**
 *  显示应用截图页面
 *  根据当前选中的标签页判断，让相应的控制器中的导航控制器加载应用截图视图控制器
 *  加载前隐藏标签栏
 *
 *  @param photos          待显示的应用截图图片地址
 *  @param selectedImageId 当前选中的图片
 */
-(void)showDetailInfoImageShowViewController:(NSArray*)photos :(NSUInteger)selectedImageId;

/**
 *  关闭应用截图页面
 *  根据当前标签页判断，推出对应的导航控制器中的应用截图视图控制器
 *  推出控制器前显示标签栏
 */
-(void)closeDetailInfoImageShowViewController;

/**
 *  根据选中的应用分类 跳转到对应的应用信息页面
 *
 *  @param titleText  应用信息控制器头部要显示的标题（如：降价—商业类，传入“商业”）
 *  @param categoryId 选中的分类id
 */
-(void)showAppListFromAppCategoryViewController:(NSString*)titleText CategoryId:(NSUInteger)categoryId;

/**
 *  显示选中的某个附近的app应用详情
 *
 *  @param appId 传入选中的应用ID
 */
-(void)showPlaceAppDetailInfo:(NSString*)appId;

/**
 *  从app详情返回到根视图控制器
 *
 */
- (void)showRootViewControllerFromPlaceAppDetailInfo;
@end
