//
//  AppCategoryCell.h
//  iFreeApp
//
//  Created by wangkai on 14-5-18.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCategoryModel.h"

@interface AppCategoryCell : UITableViewCell
{
    AppCategoryModel    *_appCategoryModel;
    
    UIImageView     *_imageView;
    UILabel         *_categoryCNameLabel;
    UILabel         *_categoryCountLabel;   //显示当前分类应用总数
    UILabel         *_currentTextLabel;     //显示当前分类某类型（限免/降价/免费/热榜）的数量
}
@property(nonatomic,assign,readwrite)AppCategoryModel *appCategoryModel;

- (void)fillData:(NSString*)categoryType;
@end
