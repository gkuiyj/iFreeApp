//
//  AppSubjectModel.m
//  iFreeApp
//
//  Created by wangkai on 14-5-21.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppSubjectModel.h"
#import "CONST.h"
#import "WKHTTPManager.h"
#import "AppSubjectCell.h"

@implementation AppSubjectModel

#pragma mark - 构造、析构
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _appSubjectArray = [[NSMutableArray alloc] init];
        _numsOnePage = 3;
    }
    return self;
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_appSubjectArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *appProductCellIdentifier = @"appSubjectCell";
    AppSubjectCell *appSubjectCell = [tableView dequeueReusableCellWithIdentifier:appProductCellIdentifier];
    if (appSubjectCell == nil)
    {
        appSubjectCell = [[[AppSubjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appProductCellIdentifier] autorelease];
    }
    appSubjectCell.appSubjectModel = [_appSubjectArray objectAtIndex:indexPath.row];
    //进行控件的数据填充
    [appSubjectCell fillData];
    
    return appSubjectCell;
}

#pragma mark - 从服务器获得数据，并设置数据源
//从服务器获得数据，并设置数据源
- (void)prepareAppSubjectModelData:(void (^)(BOOL finished))completion
{
    _currentPageNum = 1;
    NSString *urlStr = nil;
    urlStr = SUBJECT_URL(_currentPageNum,_numsOnePage);
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSArray *subjectInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (subjectInfoArray != nil) {
            [_appSubjectArray removeAllObjects];
        }
        
        [self setAppSubjectModelData:subjectInfoArray];
        
        if (completion != nil)
        {
            completion(YES);
        }
    } Failed:^(NSError *error) {
        NSLog(@"prepareAppSubjectModelData  error = %@",error);
        if (completion != nil)
        {
            completion(NO);
        }
    }];
}

////将获取的数据信息组装到数据源
- (void)setAppSubjectModelData:(NSArray *)array
{
    for (NSDictionary *dic in array) {
        AppSubjectModel *app = [[AppSubjectModel alloc]init];
        app.title = [dic objectForKey:@"title"];
        app.img = [dic objectForKey:@"img"];
        app.desc_img = [dic objectForKey:@"desc_img"];
        app.desc = [dic objectForKey:@"desc"];
        
        NSArray *array = [dic objectForKey:@"applications"];
        
        app.appInfoArray = [array mutableCopy];
        
//        for (NSDictionary *dictionary in array) {
//            [app.appInfoArray addObject:dictionary];
//        }
        //NSLog(@"array = %@",app.appInfoArray);
        [_appSubjectArray addObject:app];
        [app release];
    }
}

#pragma mark -  刷新数据
-(void)refreshDataCompletion:(void (^)(BOOL))completion
{
    _currentPageNum = 1;
    NSString *urlStr = nil;
    urlStr = SUBJECT_URL(_currentPageNum,_numsOnePage);
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSArray *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (appInfoArray != nil) {
            [_appSubjectArray removeAllObjects];
        }
        [self setAppSubjectModelData:appInfoArray];
        
        if (completion != nil) {
            completion(YES);
        }
    } Failed:^(NSError *error) {
        NSLog(@"refreshDataCompletion err");
        if (completion != nil) {
            completion(NO);
        }
    }];
}

#pragma mark -  加载更多数据
-(void)loadMoreDataCompletion:(void (^)(BOOL))completion
{
    _currentPageNum++;      //每上拉加载一次,页面数量加1
    NSString *urlStr = nil;
    urlStr = SUBJECT_URL(_currentPageNum,_numsOnePage);
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSArray *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [self setAppSubjectModelData:appInfoArray];
        
        if (completion != nil) {
            completion(YES);
        }
    } Failed:^(NSError *error) {
        NSLog(@"refreshDataCompletion err");
        if (completion != nil) {
            completion(NO);
        }
    }];
}


-(void)dealloc
{
    [_appSubjectArray release];
    _appSubjectArray = nil;
    
    [_title release];
    _title = nil;
    [_img release];
    _img = nil;
    [_desc release];
    _desc = nil;
    [_desc_img release];
    _desc_img = nil;
    
    [_applicationId release];
    _applicationId = nil;
    [_name release];
    _name = nil;
    [_iconUrl release];
    _iconUrl = nil;
    [super dealloc];
}
@end
