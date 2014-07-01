//
//  AppDetailInfo.h
//  iFreeApp
//
//  Created by wangkai on 14-5-11.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  应用详情模型类
 */
@interface AppDetailInfoModel : NSObject

@property (nonatomic,copy) NSString *appId;                 //appID
@property (nonatomic,copy) NSString *categoryId;            //appCategoryId
@property (nonatomic,copy) NSString *categoryName;          //类型名称
@property (nonatomic,retain) NSString *appIcon;             //app图标地址
@property (nonatomic,copy) NSString *appName;               //app名称
@property (nonatomic,copy) NSString *itunesUrl;             //itunes链接地址
@property (nonatomic,assign) float lastPrice;               //原价
@property (nonatomic,copy) NSString *appSize;               //app大小
@property (nonatomic,assign) float starCurrent;             //app当前星级
@property (nonatomic,copy) NSString *appDiscription;        //app描述
@property (nonatomic,copy) NSString *priceTrend;            //app限免状态
@property (nonatomic,assign) NSUInteger appShareCount;      //app分享次数
@property (nonatomic,assign) NSUInteger appCollectCount;    //app收藏次数
@property (nonatomic,assign) NSUInteger appDownloadCount;   //app下载次数
@property (nonatomic,retain) NSArray *photos;               //app展示小/大图片 存放的是字典

@property (nonatomic,retain) NSArray *placeApps;            //附近的app

- (void)prepareAppDetailInfoModelData:(NSString*)appId :(void (^)(BOOL finished))completion ;
- (void)prepareAppPlaceData;
- (void)setAppDetailInfoModelData:(NSDictionary*)dic;

@end
