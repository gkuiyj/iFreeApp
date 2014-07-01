//
//  ReducePriceModel.m
//  iFreeApp
//
//  Created by wangkai on 14-5-8.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "ReducePriceModel.h"
#import "ReducePriceInfoCell.h"
#import "WKHTTPManager.h"
#import "CONST.h"

@implementation ReducePriceModel

#pragma mark - 构造、析构
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _reducePriceArray = [[NSMutableArray alloc] init];
        _numsOnePage = 10;
    }
    return self;
}
-(void)dealloc
{
    [_reducePriceArray release];
    _reducePriceArray = nil;
    [_appId release];
    _appId = nil;
    [_categoryName release];
    _categoryName = nil;
    [_appIcon release];
    _appIcon = nil;
    [_appName release];
    _appName = nil;
    [super dealloc];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_reducePriceArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *appProductCellIdentifier = @"appProductCell";
    ReducePriceInfoCell *reducePriceInfoCell = [tableView dequeueReusableCellWithIdentifier:appProductCellIdentifier];
    if (reducePriceInfoCell == nil) {
        reducePriceInfoCell = [[[ReducePriceInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:appProductCellIdentifier] autorelease];
        reducePriceInfoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    reducePriceInfoCell.reducePriceModel = [_reducePriceArray objectAtIndex:indexPath.row];
    //进行控件的数据填充
    [reducePriceInfoCell fillData];
    
    return reducePriceInfoCell;
}


#pragma mark - 从服务器获得数据，并设置数据源
//从服务器获得数据，并设置数据源
- (void)prepareReducePriceModelData:(void (^)(BOOL finished))completion
{
    _currentPageNum = 1;
    NSString *urlStr = nil;
    
    //显示搜索数据
    if (_searchtext != nil)
    {
        urlStr = REDUCE_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = REDUCE_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {
        urlStr = REDUCE_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        if (appInfoArray != nil) {
            [_reducePriceArray removeAllObjects];
        }
        
        [self setReducePriceModelData:array];
        
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

#pragma mark -  刷新数据
-(void)refreshDataCompletion:(void (^)(BOOL))completion
{
    _currentPageNum = 1;
    NSString *urlStr = nil;
    
    //显示搜索数据
    if (_searchtext != nil)
    {
        urlStr = REDUCE_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = REDUCE_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {
        urlStr = REDUCE_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (appInfoArray != nil) {
            [_reducePriceArray removeAllObjects];
        }
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        [self setReducePriceModelData:array];
        
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

#pragma mark -  加载更多数据
-(void)loadMoreDataCompletion:(void (^)(BOOL))completion
{
    _currentPageNum++;      //每上拉加载一次,页面数量加1
    NSString *urlStr = nil;
    
    //显示搜索数据
    if (_searchtext != nil)
    {
        urlStr = REDUCE_SEARCH_URL(_currentPageNum, _numsOnePage, _searchtext);
    }
    //显示正常数据
    else if (_searchByCategoryId == 0)
    {
        urlStr = REDUCE_URL(_currentPageNum,_numsOnePage);
    }
    //按分类显示数据
    else
    {
        urlStr = REDUCE_BY_CATEGORYID_URL(_currentPageNum, _numsOnePage, _searchByCategoryId);
    }
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSDictionary *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [appInfoArray objectForKey:@"applications"];
        [self setReducePriceModelData:array];
        
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
-(void)setReducePriceModelData:(NSArray*)array
{
    for (NSDictionary *dic in array) {
        ReducePriceModel *app = [[ReducePriceModel alloc] init];
        
        app.appId = [dic objectForKey:@"applicationId"];
        app.appIcon = [dic objectForKey:@"iconUrl"];
        app.appName = [dic objectForKey:@"name"];
        app.categoryName = [dic objectForKey:@"categoryName"];
        app.starCurrent = [[dic objectForKey:@"starCurrent"]floatValue];
        app.lastPrice = [[dic objectForKey:@"lastPrice"] floatValue];
        app.appShareCount = [[dic objectForKey:@"shares"] intValue];
        app.appCollectCount = [[dic objectForKey:@"favorites"] intValue];
        app.appDownloadCount = [[dic objectForKey:@"downloads"] intValue];
        app.currentPrice = [[dic objectForKey:@"currentPrice"] floatValue];
        [_reducePriceArray addObject:app];
        
        [app release];
    }
}
@end
