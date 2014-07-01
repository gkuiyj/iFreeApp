//
//  AppCategoryModel.m
//  iFreeApp
//
//  Created by wangkai on 14-5-18.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppCategoryModel.h"
#import "AppCategoryCell.h"
#import "WKHTTPManager.h"
#import "CONST.h"

@implementation AppCategoryModel

#pragma mark - 构造、析构
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _appCategoryArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)dealloc
{
    [_appCategoryArray release];
    _appCategoryArray = nil;
    
    [_categoryCName release];
    _categoryCName = nil;
    [_categoryName release];
    _categoryName = nil;
    [_categoryId release];
    _categoryId = nil;
    [_picUrl release];
    _picUrl = nil;
    [super dealloc];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_appCategoryArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *appCategoryCellIdentifier = @"appProductCell";
    AppCategoryCell *appCategoryCell = [tableView dequeueReusableCellWithIdentifier:appCategoryCellIdentifier];
    if (appCategoryCell == nil) {
        appCategoryCell = [[[AppCategoryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:appCategoryCellIdentifier] autorelease];
        appCategoryCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    appCategoryCell.appCategoryModel = [_appCategoryArray objectAtIndex:indexPath.row];
    //进行控件的数据填充
    
    [appCategoryCell fillData:appCategoryCell.appCategoryModel.categoryType];
    
    return appCategoryCell;
}

#pragma mark - 从服务器获得数据，并设置数据源
//从服务器获得数据，并设置数据源
- (void)prepareModelData:(void (^)(BOOL finished))completion CategoryType:(NSString*)categoryType
{
    _currentPage = 1;
    NSString *urlStr = APPCATE;
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSArray *appInfoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSArray *array = [appInfoArray objectForKey:@"applications"];
        
        [self setModelData:appInfoArray CategoryType:categoryType];
        
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
-(void)setModelData:(NSArray*)array CategoryType:(NSString*)categoryType
{
    for (NSDictionary *dic in array) {
        AppCategoryModel *app = [[AppCategoryModel alloc] init];
        
        app.categoryId = [dic objectForKey:@"categoryId"];
        app.categoryName = [dic objectForKey:@"categoryName"];
        app.categoryCName = [dic objectForKey:@"categoryCname"];
        app.categoryCount = [[dic objectForKey:@"categoryCount"]intValue];
        app.picUrl = [dic objectForKey:@"picUrl"];
        
        app.limited = [[dic objectForKey:@"limited"]intValue];
        app.free = [[dic objectForKey:@"free"]intValue];
        app.down = [[dic objectForKey:@"down"]intValue];
        app.up = [[dic objectForKey:@"up"]intValue];
        app.same = [[dic objectForKey:@"same"]intValue];
        
        app.categoryType = categoryType;
        
        [_appCategoryArray addObject:app];
        
        [app release];
    }
}

@end
