//
//  AppSubjectController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSubjecInfoViewController.h"
#import "AppDetailInfoViewController.h"
#import "DetailInfoImageShowViewController.h"

@interface AppSubjectViewController : UIViewController
{
    UINavigationController              *_navigationController;         //专题标签页导航控制器
    AppSubjecInfoViewController         *_appSubjecInfoViewController;  //专题信息视图控制器
    AppDetailInfoViewController         *_appDetailInfoViewController;  //应用详情视图控制器
    DetailInfoImageShowViewController   *_detailInfoImageShowViewController;  //应用截图展示视图控制器
}
@property(retain,nonatomic,readwrite)UINavigationController *navigationController;

+(AppSubjectViewController*)shareAppSubjectViewController;

/**
 *  跳转到应用详情视图
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
 *  显示专题信息首页
 */
-(void)showRootViewController;

-(void)showPlaceAppDetailInfo:(NSString*)appId;

- (void)MY_viewDidUnLoad;
@end
