//
//  LimitFreeController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LimitFreeInfoViewController.h"
#import "AppCategoryViewController.h"
#import "SettingViewController.h"
#import "AppDetailInfoViewController.h"
#import "DetailInfoImageShowViewController.h"
#import "LimitFreeSearchViewController.h"

/**
 *  限免标签视图控制器,负责限免标签内各视图控制器的导航
 */
@interface LimitFreeViewController : UIViewController
{
    UINavigationController              *_navigationController;             //限免标签页导航控制器
    LimitFreeInfoViewController         *_limitFreeInfoViewController;      //限免信息视图控制器
    AppDetailInfoViewController         *_appDetailInfoViewController;      //应用详情视图控制器
    AppCategoryViewController           *_appCategoryViewController;        //应用分类视图控制器
    LimitFreeSearchViewController       *_limitFreeSearchViewController;    //搜索结果显示视图控制器
    DetailInfoImageShowViewController   *_detailInfoImageShowViewController;//应用截图展示视图控制器
}
@property(retain,nonatomic,readwrite)UINavigationController *navigationController;

/**
 *  获得当前对象的一个实例
 *
 *  @return LimitFreeViewController Instence
 */
+(LimitFreeViewController*)getLimitFreeViewControllerInstence;

/**
 *  跳转到应用分类视图
 */
-(void)showAppCategoryViewController;

/**
 *  跳转到设置视图
 */
-(void)showSettingViewController;

/**
 *  跳转到应用详情视图
 *
 *  @param appId 应用id
 */
-(void)showAppDetailInfoViewController:(NSString*)appId;

/**
 *  显示搜索数据
 *
 *  @param searchtext  搜索条件
 */
- (void)showLimitFreeSearchController:(NSString*)searchtext;

/**
 *  跳转到根视图(根视图默认显示为限免视图)
 */
-(void)showRootViewController;

/**
 *  显示应用详情中应用截图展示视图控制器
 *
 *  @param photos          待显示的应用截图url数组
 *  @param selectedImageId 当前选中的应用截图序号
 */
-(void)showDetailInfoImageShowViewController:(NSArray*)photos :(NSUInteger)selectedImageId;

/**
 *  关闭应用详情中应用截图视图控制器
 */
-(void)closeDetailInfoImageShowViewController;

/**
 *  选中某个应用分类后，从分类页面进入对应的应用列表,传入分类类型和分类id
 *
 *  @param titleText  分类类型
 *  @param categoryId   分类id
 */
-(void)showAppListFromAppCategoryViewController:(NSString*)titleText CategoryId:(NSUInteger)categoryId;

/**
 *  显示选中的某个附近的app应用详情
 *
 *  @param appId  选中的app id
 */
-(void)showPlaceAppDetailInfo:(NSString*)appId;

- (void)MY_viewDidUnLoad;
@end
