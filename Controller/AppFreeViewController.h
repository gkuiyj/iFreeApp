//
//  AppFreeController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppFreeInfoViewController.h"

@interface AppFreeViewController : UIViewController
{
    UINavigationController              *_navigationController;         //降价标签页导航控制器
    AppFreeInfoViewController           *_appFreeInfoViewController;     //免费视图控制器
}
@property(retain,nonatomic,readwrite)UINavigationController *navigationController;

@end
