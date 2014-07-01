//
//  AppRankSearchViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppRankModel.h"
#import "AppRankView.h"

@interface AppRankSearchViewController : UIViewController<UITableViewDelegate,AppRankViewShowAppDetailDelegate>
{
    NSString        *_searchtext;
    AppRankModel    *_appRankModel;
    AppRankView     *_appRankView;
}
@property(nonatomic,copy,readwrite)NSString *searchtext;


- (void)refreshData;
@end
