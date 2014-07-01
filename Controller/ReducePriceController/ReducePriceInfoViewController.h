//
//  ReducePriceViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-7.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReducePriceModel.h"
#import "ReducePriceInfoView.h"
#import "DataLoadingDialog.h"
#import "ModalViewController.h"
/**
 *  降价页面视图控制器，显示降价应用信息
 */
@interface ReducePriceInfoViewController : UIViewController<UITableViewDelegate,ReducePriceViewShowAppDetailDelegate,DataLoadingDialogDelegate>
{
    ReducePriceModel    *_reducePriceModel;
    ReducePriceInfoView *_reducePriceInfoView;
    
    DataLoadingDialog   *_dataLoadingDialog;
    
    NSUInteger      _categoryId;
    NSString        *_navigationItemTitleText;
    UILabel         *_titleView;
}
@property(nonatomic,readwrite,copy)NSString* navigationItemTitleText;
@property(nonatomic,readwrite,assign)NSUInteger categoryId;

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
- (void)showReducePriceSearchController:(NSString*)searchtext;
@end
