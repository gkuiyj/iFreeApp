//
//  ReducePriceModel.h
//  iFreeApp
//
//  Created by wangkai on 14-5-8.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKTableView.h"

@interface ReducePriceModel :NSObject<WKTableViewDataSource>
{
    NSMutableArray  *_reducePriceArray;
    
    int _numsOnePage;   //一页显示多少条记录
    int _currentPageNum;    //当前页数
    
}
@property (nonatomic,retain,readwrite)NSMutableArray  *reducePriceArray;

@property (nonatomic,copy) NSString *appId;                 //appID
@property (nonatomic,copy) NSString *categoryName;          //categoryName
@property (nonatomic,copy) NSString *appIcon;             //app图标地址
@property (nonatomic,copy) NSString *appName;               //app名称
@property (nonatomic,assign) float currentPrice;            //app现价
@property (nonatomic,assign) float lastPrice;               //app原价
@property (nonatomic,assign) float starCurrent;             //app当前星级
@property (nonatomic,assign) NSUInteger appShareCount;      //app分享次数
@property (nonatomic,assign) NSUInteger appCollectCount;    //app收藏次数
@property (nonatomic,assign) NSUInteger appDownloadCount;   //app下载次数

@property (nonatomic,assign,readwrite) NSUInteger searchByCategoryId; //分类id，值为0表示不需要按分类排序，
@property (nonatomic,assign,readwrite) NSString *searchtext;  //搜索数据 text

- (void)prepareReducePriceModelData:(void (^)(BOOL finished))completion;

- (void)setReducePriceModelData:(NSArray*)array;
@end
