//
//  AppRankCell.h
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppRankModel.h"

@interface AppRankCell : UITableViewCell
{
    AppRankModel    *_appRankModel;
    
    UILabel         *_appIdLabel; //用于记录appId，不显示
    UIImageView     *_appImageView;
    UILabel         *_appNameLabel;
    UILabel         *_appLastPriceLabel;
    UILabel         *_lineLabel;  //价格上的删除线
    UILabel         *_appCategoryNameLabel;
    UILabel         *_appStarLabel;
    UIImageView     *_starImageView[5]; //5颗星
    UILabel         *_appShareCountLabel;
    UILabel         *_appCollectCountLabel;
    UILabel         *_appDownloadCountLabel;
}
@property(nonatomic,retain,readwrite) AppRankModel *appRankModel;

- (void)fillData;
@end
