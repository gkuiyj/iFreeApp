//
//  LimitFreeSettingViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "SettingViewController.h"
#import "UIImageView+UIImageView_WebImage.h"
#import "MainViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        float sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (sysVersion >= 7.0) {
            UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 100, 40)];
            titleView.text = @"设置";
            [titleView setTextColor:[UIColor whiteColor]];
            titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
            [titleView setTextAlignment:NSTextAlignmentCenter];
            [self.navigationItem setTitleView:titleView];
            [titleView release];
        }
        else
        {
            self.navigationItem.title = @"设置";
        }
        self.view.backgroundColor = [UIColor whiteColor];
        
        _dataArray = [[NSArray alloc]initWithObjects:@"我的设置",@"我的关注",@"我的收藏",@"我的下载",@"我的评论",@"更多项目", nil];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    //判断系统版本，调用不同的布局方法. 不停靠在最上面(考虑导航控制器高度）
    float sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (sysVersion >= 7.0)
    {
        self.edgesForExtendedLayout =  UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;
    }
    else
    {
        self.wantsFullScreenLayout = NO;
    }
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    _topView.backgroundColor = [UIColor colorWithRed:0.4 green:0.9 blue:0.3 alpha:0.9];
    [self.view addSubview:_topView];
    
    _backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 60, 40)];
    _backButton.backgroundColor = [UIColor clearColor];
    [_backButton setTitle:@"<返回" forState:UIControlStateNormal];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_backButton];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 80, 300, 302) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.separatorColor = [UIColor colorWithHue:0.1 saturation:0.1 brightness:0.1 alpha:0.2];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    //_tableView.separatorInset  = UIEdgeInsetsMake(1, 10, 1, 10);  //NS_AVAILABLE_IOS(7_0)
    
    UIImageView *imageview = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    [imageview setImage:[UIImage imageNamed:@"背景.png"]];
    [_tableView setBackgroundView:imageview];
    
    //_tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)backButtonClick:(id)sender
{
    [[MainViewController shareMainViewController] showBackViewController];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark - UITableView DataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *cellIdentifier = @"cellIdentifier1" ;

    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableViewCell == nil) {
        tableViewCell = [[[UITableViewCell alloc]initWithStyle:
                              UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier]autorelease];
        tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        tableViewCell.backgroundColor = [UIColor clearColor];
        _cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 50)];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        [_cellView addSubview:_imageView];
        
        _cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 150, 30)];
        [_cellTitle setTextColor:[UIColor grayColor]];
        _cellTitle.font = [UIFont systemFontOfSize:18];
        [_cellView addSubview:_cellTitle];
        
        [tableViewCell.contentView addSubview:_cellView];
        
    }
    [_cellTitle setText:[NSString stringWithFormat:@"%@",_dataArray[row]]];
    switch (row) {
        case 0:
            _imageView.image = [UIImage imageNamed:@"设置_01.png"];
            break;
        case 1:
            _imageView.image = [UIImage imageNamed:@"设置_03.png"];
            break;
        case 2:
            _imageView.image = [UIImage imageNamed:@"设置_03.png"];
            break;
        case 3:
            _imageView.image = [UIImage imageNamed:@"设置_04.png"];
            break;
        case 4:
            _imageView.image = [UIImage imageNamed:@"设置_05.png"];
            break;
        case 5:
            _imageView.image = [UIImage imageNamed:@"设置_06.png"];
            break;
        default:
            break;
    }
    return tableViewCell;
}

//返回cell样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

-(void)dealloc
{
    [_tableView release];
    _tableView = nil;
    [_topView release];
    _topView = nil;
    [_backButton release];
    _backButton = nil;
    [_cellTitle release];
    _cellTitle = nil;
    [_cellView release];
    _cellView = nil;
    [_dataArray release];
    _dataArray = nil;
    [_imageView release];
    _imageView = nil;
    [super dealloc];
}


@end
