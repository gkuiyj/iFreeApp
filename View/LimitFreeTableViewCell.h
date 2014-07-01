//
//  appproduct_tableviewcellCell.h
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LimitFreeModel.h"
/**
 *  限免信息TableCell
 */
@interface LimitFreeTableViewCell : UITableViewCell
{
    LimitFreeModel *_limitFreeModel;
    
    UIImageView     *_appImageView;
    UIImageView     *_starImageView[5];
    UILabel         *_appNameLabel;
    UILabel         *_appPriceLabel;
    UILabel         *_appFreeTimeLabel;
    UILabel         *_appTypeLabel;
    UILabel         *_appShareCountLabel;
    UILabel         *_appCollectCountLabel;
    UILabel         *_appDownloadCountLabel;
}

@property (nonatomic,retain) LimitFreeModel *limitFreeModel;

- (void)fillData;
@end
