//
//  AppCategoryModel.h
//  iFreeApp
//
//  Created by wangkai on 14-5-18.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCategoryModel : NSObject<UITableViewDataSource>
{
    NSMutableArray      *_appCategoryArray;
    
    int _currentPage;
    int _currentPageNum;
}
@property(nonatomic,retain,readwrite)NSMutableArray *appCategoryArray;

@property(nonatomic,retain,readwrite)NSString *categoryCName;
@property(nonatomic,retain,readwrite)NSString *categoryId;
@property(nonatomic,retain,readwrite)NSString *categoryName;
@property(nonatomic,retain,readwrite)NSString *picUrl;

@property(nonatomic,assign,readwrite)NSUInteger categoryCount;
@property(nonatomic,assign,readwrite)NSUInteger down;
@property(nonatomic,assign,readwrite)NSUInteger free;
@property(nonatomic,assign,readwrite)NSUInteger limited;
@property(nonatomic,assign,readwrite)NSUInteger same;
@property(nonatomic,assign,readwrite)NSUInteger up;
//用于记录分类数据属于那个类型（限免分类、降价分类、免费分类、、、）
@property(nonatomic,retain,readwrite)NSString *categoryType;


- (void)prepareModelData:(void (^)(BOOL finished))completion CategoryType:(NSString*)categoryType;
- (void)setModelData:(NSArray*)array CategoryType:(NSString*)categoryType;
@end
