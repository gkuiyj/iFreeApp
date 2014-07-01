//
//  LimitFreeViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LimitFreeModel.h"
#import "LimitFreeView.h"
#import "DataLoadingDialog.h"
#import "ModalViewController.h"

/**
 *  APP限免信息视图控制器
 *
 */
@interface LimitFreeInfoViewController : UIViewController
<UITableViewDelegate,LimitFreeViewShowAppDetailDelegate,DataLoadingDialogDelegate>
{
    LimitFreeModel  *_limitFreeModel;
    LimitFreeView   *_limitFreeView;
    
    DataLoadingDialog   *_dataLoadingDialog;
    
    NSString        *_navigationItemTitleText;
    UILabel         *_titleView;
    
    //分类id，0表示查询全部分类
    NSUInteger  _categoryId;
}
@property(nonatomic,copy,readwrite)NSString *navigationItemTitleText;
@property(nonatomic,assign,readwrite)NSUInteger categoryId;

/**
 *  刷新数据
 */
- (void)refreshData;

/**
 *  跳转到显示应用详情页面
 *
 *  @param rowIndex 传入选中的行号
 */
- (void)showAppDetailInfoViewController:(NSInteger)rowIndex;

/**
 *  跳转到显示搜索结果的页面
 *
 *  @param searchtext 搜索的条件
 */
- (void)showLimitFreeSearchController:(NSString*)searchtext;
@end
