//
//  ModalView.m
//  testiOS_ModalAlertWindow
//
//  Created by wangkai on 14-4-28.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "ModalViewController.h"

@implementation ModalViewController

-(void)setModalView:(UIView *)modalView
{
    [modalView retain];
    [_modalView removeFromSuperview];
    [_modalView release];
    
    _modalView  = modalView;
    [self.view addSubview:_modalView];
}

#pragma mark - 支持旋转操作
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    float  mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    
    float  mainScreenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft
        ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        _modalView.center = CGPointMake(mainScreenHeight/2.0, mainScreenWidth/2.0);
    }
    else
    {
        _modalView.center = CGPointMake(mainScreenWidth/2.0, mainScreenHeight/2.0);
    }
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end


static UIWindow *g_alertWindow = nil;

#pragma mark - 显示模态窗口
void showModalView(UIView *view,int animateStyle)
{
    if (g_alertWindow==nil) {
        g_alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        g_alertWindow.windowLevel = UIWindowLevelAlert;
        g_alertWindow.backgroundColor = [UIColor clearColor];
        [g_alertWindow makeKeyAndVisible];
    }
    else
    {
        NSArray *subViews = [g_alertWindow subviews];
        for (int i=0; i<subViews.count; i++)
        {
            UIView *view = subViews[i];
            [view removeFromSuperview];
        }
    }
    
    ModalViewController *modalViewController = [[ModalViewController alloc]init];
    [modalViewController setModalView:view];
    g_alertWindow.rootViewController = modalViewController;
    [modalViewController release];
    
    view.layer.transform = CATransform3DIdentity;
    //以不同的动画方式载入对话框
    switch (animateStyle) {
        case 1:
            view.layer.transform = CATransform3DTranslate(view.layer.transform, 0, 300, 0);
            break;
        case 2:
            view.layer.transform = CATransform3DTranslate(view.layer.transform, 0, -300, 0);
            break;
        case 3:
            view.layer.transform = CATransform3DTranslate(view.layer.transform, -200, 0, 0);
            break;
        case 4:
            view.layer.transform = CATransform3DTranslate(view.layer.transform, 200, 0, 0);
            break;
        case 5:
            view.layer.transform = CATransform3DScale(view.layer.transform, 0.001, 0.001, 1);
            break;
        default:
            break;
    }
    //view.layer.transform = CATransform3DTranslate(view.layer.transform, 0, 300, 0);
    
    [UIView transitionWithView:view duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 关闭模态窗口
void closeModalView()
{
    [g_alertWindow release];
    g_alertWindow = nil;
}

