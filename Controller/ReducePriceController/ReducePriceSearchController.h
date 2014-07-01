//
//  WKSearchDisplayController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-10.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReducePriceModel.h"
#import "ReducePriceInfoView.h"

@interface ReducePriceSearchController : UIViewController<UITableViewDelegate,ReducePriceViewShowAppDetailDelegate>
{
    NSString            *_searchtext;
    
    ReducePriceInfoView *_reducePriceInfoView;
    ReducePriceModel    *_reducePriceModel;
}
@property(nonatomic,copy,readwrite)NSString *searchtext;


- (void)refreshData;

@end
