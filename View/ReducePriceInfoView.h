//
//  ReducePriceInfoView.h
//  iFreeApp
//
//  Created by wangkai on 14-5-9.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKTableView.h"

@protocol ReducePriceViewShowAppDetailDelegate <NSObject>

- (void)showAppDetailInfoViewController:(NSInteger)rowIndex;    //显示应用详情

@optional
- (void)showReducePriceSearchController:(NSString*)searchtext;  //显示搜索数据
@end
/**
 *  降价信息表视图
 */
@interface ReducePriceInfoView : UIView<UITableViewDelegate,UISearchBarDelegate>
{
    WKTableView     *_tableView;
    UISearchBar     *_searchBar;
    
    id  _deletage;
    
}
@property (nonatomic,assign,readwrite) WKTableView *tableView;

@property (nonatomic,assign,readwrite)id<ReducePriceViewShowAppDetailDelegate> delegate;

@property (nonatomic,assign,readwrite)id<WKTableViewDataSource> dataSource;


- (void)reloadData;
@end
