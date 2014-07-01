//
//  AppDetailInfo.m
//  iFreeApp
//
//  Created by wangkai on 14-5-11.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppDetailInfoModel.h"
#import "WKHTTPManager.h"
#import "CONST.h"

@implementation AppDetailInfoModel



#pragma mark - 从服务器获得数据，并设置数据源
//从服务器获得数据，并设置数据源
- (void)prepareAppDetailInfoModelData:(NSString*)appId :(void (^)(BOOL))completion
{
    NSString *urlStr = DETAIL_URL_RMB(appId);
    
    [WKHTTPManager requestWithUrl:urlStr Finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [self setAppDetailInfoModelData:dic];
        
        if (completion != nil)
        {
            completion(YES);
        }
    } Failed:^(NSError *error) {
        NSLog(@"AppDetailInfoModel :: prepareAppDetailInfoModelData error = %@",error);
        if (completion != nil)
        {
            completion(NO);
        }
    }];
}
//获取周边应用数据
-(void)prepareAppPlaceData
{
    NSString *urlstring = RECOMMENT_URL;
    [WKHTTPManager requestWithUrl:urlstring Finish:^(NSData *data)
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dict objectForKey:@"applications"];
        self.placeApps = array;
    } Failed:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

-(void)setAppDetailInfoModelData:(NSDictionary*)dic
{
    //AppDetailInfoModel *appModel = [[AppDetailInfoModel alloc]init];
    self.appId = [dic objectForKey:@"applicationId"];
    self.appName = [dic objectForKey:@"name"];
    self.appIcon = [dic objectForKey:@"iconUrl"];
    self.categoryName = [dic objectForKey:@"categoryName"];
    self.itunesUrl = [dic objectForKey:@"itunesUrl"];
    self.starCurrent = [[dic objectForKey:@"starCurrent"]floatValue];
    self.lastPrice = [[dic objectForKey:@"lastPrice"] floatValue];
    self.appDiscription = [dic objectForKey:@"description"];
    self.appSize = [dic objectForKey:@"fileSize"];
    self.priceTrend = [dic objectForKey:@"priceTrend"];
    self.photos = [dic objectForKey:@"photos"];
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
    [_priceTrend release];
    _priceTrend = nil;
    [_appSize release];
    _appSize = nil;
    [_appDiscription release];
    _appDiscription = nil;
    [_photos release];
    _photos = nil;
    [super dealloc];
}
@end
