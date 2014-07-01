//
//  WKTableView.h
//  iFreeApp
//
//  Created by wangkai on 14-5-16.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"

@protocol WKTableViewDataSource <NSObject, UITableViewDataSource>

@required
- (void)refreshDataCompletion:(void (^)(BOOL finished))completion;

- (void)loadMoreDataCompletion:(void (^)(BOOL finished))completion;

@end

/**
 *  自带下拉刷新和上拉加载更多的效果、WKTableView的DataSource必须遵循WKTableViewDataSource协议
 */
@interface WKTableView : UITableView<EGORefreshTableHeaderDelegate, LoadMoreTableFooterDelegate, UITableViewDelegate>
{
    EGORefreshTableHeaderView *_egoRefreshTableHeaderView;
    BOOL  _isRefreshing;
    
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    BOOL  _isLoadMoreing;
    
    id<UITableViewDelegate> _backupDelegate;
}

@property(assign,nonatomic,readwrite)id<WKTableViewDataSource> dataSource;
@end
