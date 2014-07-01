//
//  AppSubjectModel.h
//  iFreeApp
//
//  Created by wangkai on 14-5-21.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKTableView.h"

/**
 *  应用专题model
 */
@interface AppSubjectModel : NSObject<WKTableViewDataSource>
{
    NSMutableArray  *_appSubjectArray;
    
    int _numsOnePage;   //一页显示多少条记录
    int _currentPageNum;    //当前页数
}
@property (nonatomic,retain,readwrite)NSMutableArray *appSubjectArray;

@property (nonatomic,copy,readwrite) NSString *title; //专题标题
@property (nonatomic,copy,readwrite) NSString *img;   //专题图片地址
@property (nonatomic,copy,readwrite) NSString *desc;  //专题描述
@property (nonatomic,copy,readwrite) NSString *desc_img;  //描述图片地址

@property (nonatomic,copy,readwrite) NSString *applicationId;  //应用id
@property (nonatomic,copy,readwrite) NSString *name;    //应用名称
@property (nonatomic,copy,readwrite) NSString *iconUrl;     //应用图片地址
@property (nonatomic,assign,readwrite) float starOverall;   //应用星级
@property (nonatomic,assign,readwrite) NSUInteger comment;     //应用评论数
@property (nonatomic,assign,readwrite) NSUInteger downloads;   //应用下载数
@property (nonatomic,assign,readwrite) float ratingOverall;

@property (nonatomic,retain,readwrite) NSMutableArray *appInfoArray; //存放四个应用信息

- (void)prepareAppSubjectModelData:(void (^)(BOOL finished))completion;
- (void)setAppSubjectModelData:(NSArray*)array;
@end
