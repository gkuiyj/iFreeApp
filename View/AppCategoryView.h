//
//  AppCategoryView.h
//  iFreeApp
//
//  Created by wangkai on 14-5-18.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppCategoryViewController;
@interface AppCategoryView : UIView<UITableViewDelegate>
{
    UITableView     *_tableView;
    AppCategoryViewController *_delegate;
    
}
@property (nonatomic,assign,readwrite)id<UITableViewDataSource> dataSource;
@property (nonatomic,assign,readwrite)AppCategoryViewController *delegate;

- (void)reloadData;
@end
