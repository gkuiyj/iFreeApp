//
//  AppSubjecInfoViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-21.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSubjectModel.h"
#import "AppSubjectView.h"
#import "DataLoadingDialog.h"
#import "ModalViewController.h"

@interface AppSubjecInfoViewController : UIViewController<DataLoadingDialogDelegate>
{
    AppSubjectModel     *_appSubjectModel;
    AppSubjectView      *_appSubjectView;
    
    UILabel         *_titleView;
    
    DataLoadingDialog *_dataLoadingDialog;
}


/**
 *  刷新数据
 */
- (void)refreshData;
@end
