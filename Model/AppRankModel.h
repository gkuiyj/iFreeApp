//
//  AppRankModel.h
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKTableView.h"

@interface AppRankModel : NSObject<WKTableViewDataSource>
{
    NSMutableArray  *_appRankArray;
    
    int _numsOnePage;   //一页显示多少条记录
    int _currentPageNum;    //当前页数
}
@property (nonatomic,retain,readwrite)NSMutableArray  *appRankArray;

@property (nonatomic,copy) NSString *appId;                 //appID
@property (nonatomic,copy) NSString *categoryName;          //categoryName
@property (nonatomic,copy) NSString *appIcon;               //app图标地址
@property (nonatomic,copy) NSString *appName;               //app名称
@property (nonatomic,copy) NSString *appType;               //app价格类型（限免、免费、）
@property (nonatomic,assign) float lastPrice;               //app原价
@property (nonatomic,assign) float starCurrent;             //app当前星级
@property (nonatomic,assign) NSUInteger appShareCount;      //app分享次数
@property (nonatomic,assign) NSUInteger appCollectCount;    //app收藏次数
@property (nonatomic,assign) NSUInteger appDownloadCount;   //app下载次数


@property (nonatomic,assign,readwrite) NSUInteger searchByCategoryId; //分类id，值为0表示不需要按分类排序，
@property (nonatomic,assign,readwrite) NSString *searchtext;  //搜索数据 text

- (void)prepareAppRankModelData:(void (^)(BOOL finished))completion;
- (void)setAppRankModelData:(NSArray*)array;

@end
