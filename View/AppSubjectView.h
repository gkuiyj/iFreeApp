//
//  AppSubjectView.h
//  iFreeApp
//
//  Created by wangkai on 14-5-21.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKTableView.h"

@class AppSubjecInfoViewController;
@interface AppSubjectView : UIView<UITableViewDelegate>
{
    WKTableView     *_tableView;
    
    AppSubjecInfoViewController  *_delegate;
}
@property (nonatomic,assign,readwrite) WKTableView *tableView;

@property (nonatomic,assign,readwrite)id<WKTableViewDataSource> dataSource;

@property (nonatomic,assign,readwrite)AppSubjecInfoViewController  *delegate;


- (void)reloadData;

@end
