//
//  LimitFreeAppModel.m
//  iFreeApp
//
//  Created by wangkai on 14-5-8.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "LimitFreeModel.h"
#import "LimitFreeTableViewCell.h"
#import "WKHTTPManager.h"
#import "CONST.h"

@implementation LimitFreeModel

#pragma mark - 构造、析构
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _limitFreeArray = [[NSMutableArray alloc] init];
        _numsOnePage = 10;
    }
    return self;
}

-(void)dealloc
{
    [_appId release];
    _appId = nil;
    [_categoryId release];
    _categoryId = nil;
    [_categoryName release];
    _categoryName = nil;
    [_appIcon release];
    _appIcon = nil;
    [_appName release];
    _appName = nil;
    [_appType release];
    _appType = nil;
    [_appSize release];
    _appSize = nil;
    [_appDiscription release];
    _appDiscription = nil;
    [_appFreeTime release];
    _appFreeTime = nil;
    [_limitFreeArray release];
    _limitFreeArray = nil;
    [_searchtext release];
    _searchtext = nil;
    [super dealloc];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_limitFreeArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *appProductCellIdentifier = @"appProductCell";
    LimitFreeTableViewCell *limitFreeTableViewCell = [tableView dequeueReusableCellWithIdentifier:appProductCellIdentifier];
    if (limitFreeTableViewCell == nil) {
        limitFreeTableViewCell = [[[LimitFreeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:appProductCellIdentifier] autorelease];
        limitFreeTableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    limitFreeTableViewCell.limitFreeModel = [_limitFreeArray objectAtIndex:indexPath.row];
    //进行控件的数据填充
    [limitFreeTableViewCell fillData];
    
    return limitFreeTableViewCell;
}

#pragma mark - 从服务器获得数据，并设置数据源
//从服务器获得数据，并设置数据源
- (void)prepareLimitFreeModelData:(void (^)(BOOL finished))completion
{
    _currentPageNum = 1;
    NSString *urlStr = nil;
    
    //显示搜索数据
    if (_searchtext != nil)
    {
        urlStr = LIMIT_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = LIMIT_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {
        urlStr = LIMIT_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (appInfoArray != nil) {
            [_limitFreeArray removeAllObjects];
        }
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        [self setLimitFreeModelData:array];
        
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
-(void)setLimitFreeModelData:(NSArray*)array
{
    //[_appProductArray removeAllObjects];
    for (NSDictionary *dic in array) {
        LimitFreeModel *app = [[LimitFreeModel alloc] init];
        
        //获取限免结束日期，计算出剩下多少时间：时：分：秒
        NSString *dateString = [dic objectForKey:@"expireDatetime"];
        //组装为NSDate
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss.z"];
        NSDate *destDate= [dateFormatter dateFromString:dateString];
        //计算结束日期距离现在还有多少毫秒
        NSTimeInterval sec = [destDate timeIntervalSinceDate:[NSDate date]];
        //把剩余毫秒数组装成时间格式
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:sec]];
        [dateFormatter release];
        
        app.appId = [dic objectForKey:@"applicationId"];
        app.appIcon = [dic objectForKey:@"iconUrl"];
        app.appName = [dic objectForKey:@"name"];
        app.appType = [dic objectForKey:@"categoryName"];
        app.starCurrent = [[dic objectForKey:@"starCurrent"]floatValue];
        app.appPrice = [[dic objectForKey:@"lastPrice"] floatValue];
        app.appShareCount = [[dic objectForKey:@"shares"] intValue];
        app.appCollectCount = [[dic objectForKey:@"favorites"] intValue];
        app.appDownloadCount = [[dic objectForKey:@"downloads"] intValue];
        app.appFreeTime = dateStr;
        [_limitFreeArray addObject:app];
        
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
        urlStr = LIMIT_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = LIMIT_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {
        urlStr = LIMIT_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data){
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:NSJSONReadingMutableContainers error:nil];
        if (appInfoArray != nil) {
            [_limitFreeArray removeAllObjects];
        }
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        [self setLimitFreeModelData:array];
        
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

#pragma mark - LoadMoreTableFooterDelegate Methods
//上拉加载更多数据
-(void)loadMoreDataCompletion:(void (^)(BOOL))completion
{
    _currentPageNum++;      //每下拉加载一次,页面数量加1
    NSString *urlStr = nil;
    
    //显示搜索数据
    if (_searchtext != nil)
    {
        urlStr = LIMIT_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = LIMIT_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {
        urlStr = LIMIT_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        [self setLimitFreeModelData:array];
        
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
