//
//  ReducePriceInfoCell.h
//  iFreeApp
//
//  Created by wangkai on 14-5-9.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReducePriceModel.h"
/**
 *  降价信息TableCell
 */
@interface ReducePriceInfoCell : UITableViewCell
{
    ReducePriceModel    *_reducePriceModel;
    
    UILabel         *_appIdLabel; //用于记录appId，不显示
    
    UIImageView     *_appImageView;
    UIImageView     *_starImageView[5]; //5颗星

    UILabel         *_appNameLabel;
    UILabel         *_appCurrentPriceLabel;
    UILabel         *_appLastPriceLabel;
    UILabel         *_appCategoryNameLabel;
    UILabel         *_appShareCountLabel;
    UILabel         *_appCollectCountLabel;
    UILabel         *_appDownloadCountLabel;
}
@property (nonatomic,retain,readwrite)ReducePriceModel *reducePriceModel;

- (void)fillData;
@end
