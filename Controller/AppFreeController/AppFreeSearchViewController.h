//
//  AppFreeSearchViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppFreeView.h"
#import "AppFreeModel.h"

/**
 *  免费应用 搜索结果显示页
 */
@interface AppFreeSearchViewController : UIViewController<UITableViewDelegate,AppFreeViewShowAppDetailDelegate>
{
    NSString        *_searchtext;
    AppFreeModel    *_appFreeModel;
    AppFreeView     *_appFreeView;
}
@property(nonatomic,copy,readwrite)NSString *searchtext;

- (void)refreshData;

@end
