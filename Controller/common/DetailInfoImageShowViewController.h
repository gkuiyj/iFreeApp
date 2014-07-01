//
//  DetailInfoImageShowViewController.h
//  iFreeApp
//
//  Created by wangkai on 14-5-16.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailInfoImageShowView.h"

/**
 *  应用详情中应用截图放大显示 视图控制器
 */
@interface DetailInfoImageShowViewController : UIViewController
{
    DetailInfoImageShowView  *_detailInfoImageShowView;
    
    NSArray     *_detailInfoImageShowViewPhotos;     //存放待显示的应用截图url
    NSUInteger  _selectedImageId;               //选中的图片id
}
@property(retain,nonatomic,readwrite)NSArray *detailInfoImageShowViewPhotos;
@property(assign,nonatomic,readwrite)NSUInteger  selectedImageId;

- (void)closeImageShowView;
- (void)removeDetailInfoImageShowView;
- (void)showDetailInfoImageShowView;
@end
