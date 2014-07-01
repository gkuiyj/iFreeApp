//
//  LimitFreeViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "LimitFreeInfoViewController.h"
#import "LimitFreeViewController.h"
#import "LimitFreeTableViewCell.h"
#import "WKHTTPManager.h"
#import "AppLog.h"
#import "UIDevice+UIDeviceCategory.h"

@interface LimitFreeInfoViewController ()

@end

@implementation LimitFreeInfoViewController
#pragma mark - 初始化，析构函数 
- (id)init
{
    self = [super init];
    if (self) {
        _navigationItemTitleText = @"限免";
        if ([UIDevice systemVersionFirstNumber] >= 7) {
            _titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 100, 40)];
            _titleView.text = _navigationItemTitleText;
            [_titleView setTextColor:[UIColor whiteColor]];
            _titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
            [_titleView setTextAlignment:NSTextAlignmentCenter];
            [self.navigationItem setTitleView:_titleView];
            [_titleView release];
        }
        else
        {
            self.navigationItem.title = _navigationItemTitleText;
        }
        //设置导航视图顶部左右按钮的背景图片,样式 以及单击事件
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_分类_正常.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick:)];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        [rightBarButtonItem release];
        
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_设置_正常.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick:)];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        [leftBarButtonItem release];

    }
    return self;
}

-(void)setNavigationItemTitleText:(NSString *)navigationItemTitleText
{
    if ([UIDevice systemVersionFirstNumber] >= 7)
    {
        _titleView.text = navigationItemTitleText;
    }else
    {
        self.navigationItem.title = _navigationItemTitleText;
    }
}

-(void)dealloc
{
    [_titleView release];
    _titleView = nil;
    [_navigationItemTitleText release];
    _navigationItemTitleText = nil;
    [_limitFreeModel release];
    _limitFreeModel = nil;
    [_limitFreeView release];
    _limitFreeView = nil;
    [super dealloc];
}

#pragma mark - 导航按钮点击事件
-(void)rightBarButtonClick:(id)sender
{
    [[LimitFreeViewController getLimitFreeViewControllerInstence] showAppCategoryViewController];
}
-(void)leftBarButtonClick:(id)sender
{
    [[LimitFreeViewController getLimitFreeViewControllerInstence] showSettingViewController];
}

#pragma mark - loadView
-(void)loadView
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
    _limitFreeModel = [[LimitFreeModel alloc]init];
    _limitFreeView = [[LimitFreeView alloc]init];
    _limitFreeView.delegate = self;
    _limitFreeView.dataSource = _limitFreeModel;
    self.view = _limitFreeView;
    
    //第一次加载视图时刷新数据
    [self refreshData];
}

//重新加载_tableView的数据
- (void)refreshData;
{
    [self showDataLoadingDialog];
    //刷新数据
    _limitFreeModel.searchByCategoryId = _categoryId;
    [_limitFreeModel prepareLimitFreeModelData:^(BOOL finished) {
        if (finished)
        {
            [_limitFreeView reloadData];
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
    }];
}

- (void)dismissAlertView:(NSTimer *)timer
{
    UIAlertView *alert = [[timer userInfo]  objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - UITableView Delegate
//返回UITableView Cell 高度，默认44
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (void)showAppDetailInfoViewController:(NSInteger)rowIndex
{
    LimitFreeModel *model = _limitFreeModel.limitFreeArray[rowIndex];
    [[LimitFreeViewController getLimitFreeViewControllerInstence] showAppDetailInfoViewController:model.appId];
}

- (void)showLimitFreeSearchController:(NSString*)searchtext
{
    [[LimitFreeViewController getLimitFreeViewControllerInstence] showLimitFreeSearchController:searchtext];
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
