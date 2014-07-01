//
//  AppFreeInfoViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-22.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppFreeModel.h"
#import "AppFreeView.h"

@interface AppFreeInfoViewController : UIViewController<UITableViewDelegate,AppFreeViewShowAppDetailDelegate>
{
    AppFreeModel    *_appFreeModel;
    AppFreeView     *_appFreeView;
    
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


@end
