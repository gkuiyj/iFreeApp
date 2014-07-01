//
//  AppRankModel.m
//  iRanApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppRankModel.h"
#import "AppRankCell.h"
#import "WKHTTPManager.h"
#import "CONST.h"

@implementation AppRankModel

#pragma mark - 构造、析构
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _appRankArray = [[NSMutableArray alloc] init];
        _numsOnePage = 10;
    }
    return self;
}
-(void)dealloc
{
    [_appRankArray release];
    _appRankArray = nil;
    [_appId release];
    _appId = nil;
    [_categoryName release];
    _categoryName = nil;
    [_appIcon release];
    _appIcon = nil;
    [_appName release];
    _appName = nil;
    [_appType release];
    _appType = nil;
    [super dealloc];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_appRankArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *appProductCellIdentifier = @"appRankCell";
    AppRankCell *appRankCell = [tableView dequeueReusableCellWithIdentifier:appProductCellIdentifier];
    if (appRankCell == nil) {
        appRankCell = [[[AppRankCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:appProductCellIdentifier] autorelease];
        appRankCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    appRankCell.appRankModel = [_appRankArray objectAtIndex:indexPath.row];
    //进行控件的数据填充
    [appRankCell fillData];
    
    return appRankCell;
}

#pragma mark - 从服务器获得数据，并设置数据源
//从服务器获得数据，并设置数据源
- (void)prepareAppRankModelData:(void (^)(BOOL finished))completion
{
    _currentPageNum = 1;
    NSString *urlStr = nil;
    
    //显示搜索数据
    if (_searchtext != nil)
    {
        //NSString *searchString = [_searchtext stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        urlStr = HOT_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = HOT_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {NSLog(@"_searchByCategoryId = %d",_searchByCategoryId);
        urlStr = HOT_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        
        if (appInfoArray != nil) {
            [_appRankArray removeAllObjects];
        }
        
        [self setAppRankModelData:array];
        
        if (completion != nil)
        {
            completion(YES);
        }
    } Failed:^(NSError *error) {
        NSLog(@"error = %@",error);
        if (completion != nil)
        {
            completion(NO);
        }
    }];
}

//将获取的数据信息组装到数据源
-(void)setAppRankModelData:(NSArray*)array
{
    for (NSDictionary *dic in array) {
        AppRankModel *app = [[AppRankModel alloc] init];
        
        app.appId = [dic objectForKey:@"applicationId"];
        app.appIcon = [dic objectForKey:@"iconUrl"];
        app.appName = [dic objectForKey:@"name"];
        app.categoryName = [dic objectForKey:@"categoryName"];
        app.starCurrent = [[dic objectForKey:@"starCurrent"]floatValue];
        app.lastPrice = [[dic objectForKey:@"lastPrice"] floatValue];
        app.appShareCount = [[dic objectForKey:@"shares"] intValue];
        app.appCollectCount = [[dic objectForKey:@"favorites"] intValue];
        app.appDownloadCount = [[dic objectForKey:@"downloads"] intValue];
        app.appType = [dic objectForKey:@"appType"];
        
        [_appRankArray addObject:app];
        [app release];
    }
}


#pragma mark -  刷新数据
-(void)refreshDataCompletion:(void (^)(BOOL))completion
{
    _currentPageNum = 1;
    NSString *urlStr = nil;
    
    //显示搜索数据
    if (_searchtext != nil)
    {
        urlStr = HOT_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = HOT_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {
        urlStr = HOT_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (appInfoArray != nil) {
            [_appRankArray removeAllObjects];
        }
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        [self setAppRankModelData:array];
        
        if (completion != nil)
        {
            completion(YES);
        }
    } Failed:^(NSError *error)
    {
        NSLog(@"error = %@",error);
        if (completion != nil)
        {
            completion(NO);
        }
    }];
}

#pragma mark -  加载更多数据
-(void)loadMoreDataCompletion:(void (^)(BOOL))completion
{
    _currentPageNum++;      //每上拉加载一次,页面数量加1
    NSString *urlStr = nil;
    
    //显示搜索数据
    if (_searchtext != nil)
    {
        urlStr = HOT_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = HOT_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {
        urlStr = HOT_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data)
    {
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        [self setAppRankModelData:array];
        
        if (completion != nil)
        {
            completion(YES);
        }
    } Failed:^(NSError *error) {
        NSLog(@"error = %@",error);
        if (completion != nil)
        {
            completion(NO);
        }
    }];
}

@end
