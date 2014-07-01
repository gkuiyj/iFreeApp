//
//  AppFreeViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-22.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppFreeInfoViewController.h"
#import "AppCategoryViewController.h"
#import "AppDetailInfoViewController.h"
#import "DetailInfoImageShowViewController.h"
#import "AppFreeSearchViewController.h"

/**
 *  免费应用控制类,负责管理免费应用相关的视图控制器
 */
@interface AppFreeViewController : UIViewController
{
    UINavigationController          *_navigationController;             //导航控制器
    AppFreeInfoViewController       *_appFreeInfoViewController;        //免费应用信息视图控制器
    AppCategoryViewController       *_appCategoryViewController;        //应用分类视图控制器
    AppDetailInfoViewController     *_appDetailInfoViewController;      //应用详情视图控制器
    AppFreeSearchViewController     *_appFreeSearchViewController;      //免费应用搜索视图控制器
    
    DetailInfoImageShowViewController   *_detailInfoImageShowViewController;  //应用截图展示视图控制器
}
@property(retain,nonatomic,readwrite)UINavigationController *navigationController;

+(AppFreeViewController*)shareAppFreeViewController;

/**
 *  显示应用分类
 */
-(void)showAppCategoryViewController;

/**
 *  显示系统设置页面
 */
-(void)showSettingViewController;

/**
 *  显示应用详情
 *
 *  @param appId 应用id
 */
-(void)showAppDetailInfoViewController:(NSString*)appId;

/**
 *  显示应用截图页面，传入待显示的图片和当前选中的图片id
 *
 *  @param photos          待显示的图片地址
 *  @param selectedImageId 当前选中的图片id
 */
-(void)showDetailInfoImageShowViewController:(NSArray*)photos :(NSUInteger)selectedImageId;

/**
 *  关闭应用截图页面
 */
-(void)closeDetailInfoImageShowViewController;

/**
 *  选中某个应用分类后，从分类页面进入对应的应用列表
 *
 *  @param titleText  控制器头部要显示的标题
 *  @param categoryId 选中的分类id
 */
-(void)showAppListFromAppCategoryViewController:(NSString*)titleText CategoryId:(NSUInteger)categoryId;

/**
 *  显示搜索数据
 *
 *  @param searchtext  搜索条件
 */
- (void)showAppFreeSearchController:(NSString*)searchtext;

-(void)showPlaceAppDetailInfo:(NSString*)appId;

- (void)showRootViewController;

- (void)MY_viewDidUnLoad;
@end
