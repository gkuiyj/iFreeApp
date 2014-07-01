//
//  AppFreeView.h
//  iFreeApp
//
//  Created by wangkai on 14-5-22.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKTableView.h"

@protocol AppFreeViewShowAppDetailDelegate <NSObject>

- (void)showAppDetailInfoViewController:(NSInteger)rowIndex;    //显示应用详情

@optional
- (void)showAppFreeSearchController:(NSString*)searchtext;  //显示搜索数据
@end

@interface AppFreeView : UIView<UITableViewDelegate,UISearchBarDelegate>
{
    WKTableView     *_tableView;
    UISearchBar     *_searchBar;
    
    id  _deletage;
    
}
@property (nonatomic,assign,readwrite) WKTableView *tableView;

@property (nonatomic,assign,readwrite)id<AppFreeViewShowAppDetailDelegate> delegate;

@property (nonatomic,assign,readwrite)id<WKTableViewDataSource> dataSource;


- (void)reloadData;
@end
