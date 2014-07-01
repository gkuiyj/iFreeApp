//
//  AppDetailInfoView.h
//  iFreeApp
//
//  Created by wangkai on 14-5-11.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDetailInfoModel.h"
#import "WKImageView.h"
/**
 *  应用详情类
 */
@class AppDetailInfoViewController;
@interface AppDetailInfoView : UIView<UIActionSheetDelegate>
{
    UILabel         *_appIdLabel;        //记录appId，不显示
    UILabel         *_appItunesLabel;       //记录appitunes地址
    
    UIImageView     *_imageView;            //上部份 应用详情
    UIImageView     *_appImageView;         //app图标
    UILabel         *_appNameLabel;         //app名称
    UILabel         *_lastPriceLabel;       //app原价
    UILabel         *_priceTrendLabel;      //app限免状态
    UILabel         *_categoryNameLabel;    //app类型
    UILabel         *_appSizeLabel;         //app大小
    UILabel         *_starCurrentLabel;     //app当前评分
    
    UIImageView     *_buttonImageView;      //按钮背景
    UIButton        *_buttonShare;          //分享按钮
    UIButton        *_buttonCollect;        //收藏按钮
    UIButton        *_buttonDown;           //下载按钮
    UIImageView     *_lineImage1;           //按钮分割线
    UIImageView     *_lineImage2;
    UIActionSheet   *_shareActionSheet;     //分享按钮对话框
    
    UIScrollView    *_imageScrollView;      //图片展示视图
    
    WKImageView     *_imageSmallUrl[5];      //5张app展示小图片
    
    UILabel         *_appDiscription;       //app简介
    
    UIImageView     *_imageView4PlaceApp;   //下部分 附近的人、、
    UIScrollView    *_placeScrollView;      //附近的app滚动视图
    UILabel         *_labelTitle;           //附近的人 标题
    WKImageView     *_placeAppImageView[5]; //5个附近的app的图片
    UILabel         *_placeAppName[5];      //5个附近的app的名字

    AppDetailInfoViewController *_delegate;
}
@property(nonatomic,assign,readwrite)AppDetailInfoViewController *delegate;

//填充UI数据
- (void)fillData:(AppDetailInfoModel*)appModel;
@end