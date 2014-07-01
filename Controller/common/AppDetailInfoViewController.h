//
//  AppDetailInfoViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-7.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDetailInfoView.h"
#import "AppDetailInfoModel.h"
#import "DataLoadingDialog.h"
#import "ModalViewController.h"

/**
 *  应用详情视图控制器 负责显示应用详情
 */
@interface AppDetailInfoViewController : UIViewController<DataLoadingDialogDelegate>
{
    AppDetailInfoView   *_appDetailInfoView;
    AppDetailInfoModel  *_appDetailInfoModel;
    
    DataLoadingDialog   *_dataLoadingDialog;
    
    NSString            *_appId;
}
@property (copy,nonatomic,readwrite)NSString *appId;

+ (AppDetailInfoViewController*)shareAppDetailInfoViewController;

/**
 *  刷新UI数据
 *
 */
- (void)refreshData;

/**
 *  显示应用截图
 *
 *  @param selectedImageId 传入选中的图片id
 */
- (void)showImageShowView:(NSUInteger)selectedImageId;

/**
 *  显示选中到某个附近的app应用详情
 *
 *  @param appId 传入选中的应用id
 */
- (void)showPalceAppDetailInfo:(NSString*)appId;
@end
