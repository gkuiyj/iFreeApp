//
//  LimitFreeCategoryViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppCategoryViewController.h"
#import "MainViewController.h"

@interface AppCategoryViewController ()

@end

@implementation AppCategoryViewController

#pragma mark - 初始化函数
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)dealloc
{
    [_appCategoryView release];
    _appCategoryView = nil;
    [_appCategoryModel release];
    _appCategoryModel = nil;
    [_categoryType release];
    _categoryType = nil;
    [super dealloc];
}

#pragma mark - 加载视图
- (void)loadView
{
    [super loadView];
    _appCategoryView = [[AppCategoryView alloc]initWithFrame:self.view.bounds];
    _appCategoryView.backgroundColor = [UIColor yellowColor];
    _appCategoryView.delegate = self;
    
    _appCategoryModel = [[AppCategoryModel alloc]init];
    _appCategoryView.dataSource = _appCategoryModel;
    
    [self.view addSubview:_appCategoryView];
    [self refreshData];
}

#pragma mark - 刷新页面数据
- (void)refreshData
{
    [self showDataLoadingDialog];
    //刷新数据
    [_appCategoryModel prepareModelData:^(BOOL finished)
    {
        if (finished)
        {
            [_appCategoryView reloadData];
            closeModalView();
        }
        else
        {
            closeModalView();
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的网络不给力！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlertView:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert",nil] repeats:NO];
            [alertView release];
        }
    } CategoryType:_categoryType];
}

- (void)dismissAlertView:(NSTimer *)timer
{
    UIAlertView *alert = [[timer userInfo]  objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - 刷新页面数据
-(void)showAppListFromAppCategoryViewController:(NSUInteger)index
{
    NSString *titleText = nil;
    AppCategoryModel *model = _appCategoryModel.appCategoryArray[index];
    if (index != 0)
    {
        titleText =  model.categoryCName;
    }
    [[MainViewController shareMainViewController] showAppListFromAppCategoryViewController:titleText CategoryId:[model.categoryId intValue]];
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
