//
//  LimitFreeSettingViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  系统设置页面视图控制器
 */
@interface SettingViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UIView          *_topView;
    UIButton        *_backButton;
    
    UITableView     *_tableView;
    NSArray         *_dataArray;
    UIView          *_cellView;
    UIImageView     *_imageView;
    UILabel         *_cellTitle;
}

@end
