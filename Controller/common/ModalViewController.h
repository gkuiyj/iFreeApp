//
//  ModalView.h
//  testiOS_ModalAlertWindow
//
//  Created by wangkai on 14-4-28.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DataLoadingDialog.h"

/**
 *  模态窗口控制器
 *
 *  将对话框传入此控制器，并以模态方式显示
 */
@interface ModalViewController : UIViewController 
{
    UIView *_modalView;
    
}
@property(retain,nonatomic)UIView *modalView;
@end

/**
 *  显示模态对话框
 *
 *  @param view         传入待显示的对话框
 *  @param ainmateStyle 设置对话框载入的动画方式
 */
void showModalView(UIView *view,int ainmateStyle);

void closeModalView();