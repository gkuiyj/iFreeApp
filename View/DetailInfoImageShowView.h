//
//  DetailInfoImageShowView.h
//  iFreeApp
//
//  Created by wangkai on 14-5-16.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailInfoImageShowViewController;
@interface DetailInfoImageShowView : UIView<UIScrollViewDelegate>
{
    UIScrollView    *_scrollView;
    UIPageControl   *_pageControl;
    UIView          *_topView;
    UIButton        *_closeButton;
    UILabel         *_pageNumLabel;
    UILabel         *_currentPageNumLabel;
    
    UIImageView     *_imageView[5];
    
    DetailInfoImageShowViewController *_delegate;
}
@property(nonatomic,assign,readwrite)DetailInfoImageShowViewController *delegate;
@property(nonatomic,retain,readwrite)UIScrollView *scrollView;
@property(nonatomic,retain,readwrite)UILabel *pageNumLabel;
@property(nonatomic,retain,readwrite)UILabel *currentPageNumLabel;
@property(nonatomic,retain,readwrite)UIPageControl  *pageControl;

- (void)setImageShowViewBigImage:(NSArray*)imagesArray;

@end
