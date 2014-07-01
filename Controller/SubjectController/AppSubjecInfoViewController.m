//
//  AppSubjecInfoViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-21.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppSubjecInfoViewController.h"
#import "UIDevice+UIDeviceCategory.h"
#import "AppLog.h"


@interface AppSubjecInfoViewController ()

@end

@implementation AppSubjecInfoViewController

- (id)init
{
    self = [super init];
    if (self) {
        if ([UIDevice systemVersionFirstNumber] >= 7) {
            _titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 0, 100, 20)];
            _titleView.text = @"专题";
            [_titleView setTextColor:[UIColor whiteColor]];
            _titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
            [_titleView setTextAlignment:NSTextAlignmentCenter];
            [self.navigationItem setTitleView:_titleView];
            [_titleView release];
        }
        else
        {
            self.navigationItem.title = @"专题";
        }
    }
    return self;
}

#pragma mark - 视图控制器的函数

- (void)loadView
{
    [super loadView];
    
    if ([UIDevice systemVersionFirstNumber] < 7)
    {
        self.wantsFullScreenLayout = NO;
    }
    else
    {
        self.edgesForExtendedLayout = UIRectEdgeBottom|UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    _appSubjectView = [[AppSubjectView alloc] initWithFrame:self.view.bounds];
    _appSubjectView.delegate = self;
    _appSubjectModel = [[AppSubjectModel alloc] init];
    _appSubjectView.dataSource = _appSubjectModel;
    
    self.view = _appSubjectView;
    
    //第一次加载视图时刷新数据
    [self refreshData];
}


- (void)refreshData
{
    [self showDataLoadingDialog];
    //刷新数据
    [_appSubjectModel prepareAppSubjectModelData:^(BOOL finished) {
        if (finished)
        {
            [_appSubjectView reloadData];
            closeModalView();
        }
        else
        {
            closeModalView();
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"网络超时！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlertView:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert",nil] repeats:NO];
            [alertView release];
        }
    }];
}

- (void)dismissAlertView:(NSTimer *)timer
{
    UIAlertView *alert = [[timer userInfo]  objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - 显示数据正在加载对话框(模态)
- (void)showDataLoadingDialog
{
    _dataLoadingDialog = [[DataLoadingDialog alloc]initWithFrame:CGRectMake(0 , 0, 200, 150)];
    _dataLoadingDialog.center = CGPointMake(160, 240);
    _dataLoadingDialog.text = @"正在努力加载中···";
    _dataLoadingDialog.delegate = self;
    
    [_dataLoadingDialog startActivity];
    
    showModalView(_dataLoadingDialog,5);
    
    [_dataLoadingDialog release];
}

- (void)DataLoadingDialogDidCancel:(DataLoadingDialog *)dataLoadingDialog
{
    closeModalView();
}
@end
