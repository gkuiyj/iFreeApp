//
//  DataLoadingDialog.h
//  iFreeApp
//
//  Created by wangkai on 14-6-8.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataLoadingDialog;

@protocol DataLoadingDialogDelegate <NSObject>

-(void)DataLoadingDialogDidCancel:(DataLoadingDialog*)dataLoadingDialog;
@end

/**
 *  数据加载状态提示框
 */
@interface DataLoadingDialog : UIView
{
    UILabel *_label;
    UIActivityIndicatorView *_activityIndicatorView;
    UIButton *_button;
    id  _delegate;
}
@property(copy, nonatomic, readwrite)NSString *text;
@property(retain, nonatomic, readwrite)id<DataLoadingDialogDelegate> delegate;

-(void)startActivity;
-(void)stopActivity;
@end
