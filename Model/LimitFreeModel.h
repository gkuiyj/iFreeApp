//
//  LimitFreeAppModel.h
//  iFreeApp
//
//  Created by wangkai on 14-5-8.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKTableView.h"

/**
 *  限免模型，为限免视图中TableView提供数据源
 */
@interface LimitFreeModel : NSObject<WKTableViewDataSource>
{
    NSMutableArray  *_limitFreeArray;

    int _numsOnePage;       //一页显示多少条记录
    int _currentPageNum;    //当前页数
    
    NSUInteger  _categorysId;    //分类id，0表示查询全部分类
}
@property (nonatomic,retain,readwrite)NSMutableArray  *limitFreeArray;

@property (nonatomic,copy) NSString *appId;                 //appID
@property (nonatomic,copy) NSString *categoryId;            //appCategoryId
@property (nonatomic,copy) NSString *categoryName;          //categoryName
@property (nonatomic,retain) NSString *appIcon;             //app图标地址
@property (nonatomic,copy) NSString *appName;               //app名称
@property (nonatomic,assign) float appPrice;                //app价格
@property (nonatomic,copy) NSString *appType;               //app类型
@property (nonatomic,copy) NSString *appSize;               //app大小
@property (nonatomic,assign) float starCurrent;             //app当前星级
@property (nonatomic,copy) NSString *appDiscription;        //app描述
@property (nonatomic,copy) NSString *appFreeTime;           //app限免剩余时间
@property (nonatomic,assign) NSUInteger appShareCount;      //app分享次数
@property (nonatomic,assign) NSUInteger appCollectCount;    //app收藏次数
@property (nonatomic,assign) NSUInteger appDownloadCount;   //app下载次数
@property (nonatomic,assign) NSUInteger appGrade;           //app评分


//@property (nonatomic,readwrite,assign)BOOL  isCategory;     //是否按分类显示应用

@property (nonatomic,assign,readwrite) NSUInteger searchByCategoryId; //分类id，值为0表示不需要按分类排序，
@property (nonatomic,copy,readwrite) NSString *searchtext;  //搜索数据 text


/**
 *  从服务器获得数据,并设置数据源
 */
- (void)prepareLimitFreeModelData:(void (^)(BOOL finished))completion;

/**
 *  设置数据源
 *
 *  @param array 下载并解析后的数据
 */
-(void)setLimitFreeModelData:(NSArray*)array;

@end
