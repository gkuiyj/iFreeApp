//
//  AppRankViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppRankInfoViewController.h"
#import "AppDetailInfoViewController.h"
#import "AppRankSearchViewController.h"
#import "AppCategoryViewController.h"
#import "DetailInfoImageShowViewController.h"

@interface AppRankViewController : UIViewController
{
    AppRankInfoViewController       *_appRankInfoViewController;
    UINavigationController          *_navigationController;
    AppCategoryViewController       *_appCategoryViewController;        //应用分类视图控制器
    AppDetailInfoViewController     *_appDetailInfoViewController;      //应用详情视图控制器
    AppRankSearchViewController     *_appRankSearchViewController;      //免费应用搜索视图控制器
    
    DetailInfoImageShowViewController   *_detailInfoImageShowViewController;  //应用截图展示视图控制器
}
@property(retain,nonatomic,readwrite)UINavigationController *navigationController;

+(AppRankViewController*)shareAppRankViewController;

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
- (void)showAppRankSearchController:(NSString*)searchtext;


-(void)showPlaceAppDetailInfo:(NSString*)appId;

- (void)showRootViewController;

- (void)MY_viewDidUnLoad;
@end
