//
//  LimitFreeCategoryViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCategoryView.h"
#import "AppCategoryModel.h"
#import "DataLoadingDialog.h"
#import "ModalViewController.h"

/**
 *  应用分类视图控制器 负责显示应用分类（限免分类/降价分类/免费分类/热榜分类 通用）
 */
@interface AppCategoryViewController : UIViewController<DataLoadingDialogDelegate>
{
    AppCategoryView     *_appCategoryView;
    AppCategoryModel    *_appCategoryModel;
    
    DataLoadingDialog   *_dataLoadingDialog;
    
    NSString            *_categoryType;     //(分类页面通用)用于记录分类页面的类型（限免分类/降价分类/免费分类/热榜分类）
}
@property(nonatomic,copy,readwrite)NSString *categoryType;

/**
 *  刷新UI数据
 *
 */
- (void)refreshData;

/**
 *  按分类显示app列表
 *
 *  index 传入分类id
 */
- (void)showAppListFromAppCategoryViewController:(NSUInteger)index ;
@end
