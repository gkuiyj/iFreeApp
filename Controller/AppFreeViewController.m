//
//  AppFreeController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppFreeViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "MainViewController.h"

@interface AppFreeViewController ()

@end

@implementation AppFreeViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    _appFreeInfoViewController          = [[AppFreeInfoViewController alloc]init];
    
    _navigationController = [[UINavigationController alloc]initWithRootViewController:_appFreeInfoViewController];
    _navigationController.view.frame = self.view.bounds;
    [self.view addSubview:_navigationController.view];
}


@end
