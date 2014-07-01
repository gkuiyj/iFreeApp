//
//  LimitFreeSearchViewController.h
//  iFreeApp
//
//  Created by qianfeng on 14-6-7.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LimitFreeView.h"
#import "LimitFreeModel.h"

@interface LimitFreeSearchViewController : UIViewController<UITableViewDelegate,LimitFreeViewShowAppDetailDelegate>
{
    NSString            *_searchtext;
    
    LimitFreeView       *_limitFreeView;
    LimitFreeModel      *_limitFreeModel;
}
@property(nonatomic,copy,readwrite)NSString *searchtext;

- (void)refreshData;
@end
