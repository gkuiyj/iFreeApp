//
//  LimitFreeView.h
//  iFreeApp
//
//  Created by wangkai on 14-6-7.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKTableView.h"

@protocol LimitFreeViewShowAppDetailDelegate <NSObject>

- (void)showAppDetailInfoViewController:(NSInteger)rowIndex;    //显示应用详情

@optional
- (void)showLimitFreeSearchController:(NSString*)searchtext;  //显示搜索数据
@end

@interface LimitFreeView : UIView<UITableViewDelegate,UISearchBarDelegate>
{
    WKTableView     *_tableView;
    UISearchBar     *_searchBar;
    
    id  _deletage;
    
}
@property (nonatomic,assign,readwrite) WKTableView *tableView;

@property (nonatomic,assign,readwrite)id<LimitFreeViewShowAppDetailDelegate> delegate;

@property (nonatomic,assign,readwrite)id<WKTableViewDataSource> dataSource;

- (void)reloadData;

@end
