//
//  DetailInfoImageShowView.m
//  iFreeApp
//
//  Created by wangkai on 14-5-16.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "DetailInfoImageShowView.h"
#import "UIImageView+UIImageView_WebImage.h"
#import "AppDetailInfoViewController.h"
#import "DetailInfoImageShowViewController.h"

@implementation DetailInfoImageShowView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        float w =frame.size.width;
        float h =frame.size.height;
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
        _scrollView.contentSize = CGSizeMake(w*5, h);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(w/2.0-50, h-30, 100, 30)];
        _pageControl.numberOfPages = 5;
        [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, w, 30)];
        _topView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.4];
        _topView.layer.borderColor = [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8] CGColor];
        //_topView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        [self addSubview:_topView];
        
        _closeButton = [[UIButton alloc]initWithFrame:CGRectMake(w-60, 2, 50, 26)];
        _closeButton.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
        [_closeButton setTitle:@"Done" forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _closeButton.layer.cornerRadius = 6;
        [_closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:_closeButton];
        
        _pageNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/2.0, 20, 40, 30)];
        _pageNumLabel.backgroundColor = [UIColor clearColor];
        _pageNumLabel.textAlignment = NSTextAlignmentLeft;
        [_pageNumLabel setTextColor:[UIColor whiteColor]];
        _pageNumLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_pageNumLabel];
        _currentPageNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/2.0-40, 20, 40, 30)];
        _currentPageNumLabel.backgroundColor = [UIColor clearColor];
        _currentPageNumLabel.textAlignment = NSTextAlignmentRight;
        [_currentPageNumLabel setTextColor:[UIColor whiteColor]];
        _currentPageNumLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_currentPageNumLabel];
        
        for (int i = 0; i < 5; i++)
        {
            _imageView[i] = [[UIImageView alloc]initWithFrame:CGRectMake(i*w, 0, w , h)];
            _imageView[i].contentMode = UIViewContentModeScaleAspectFit;
            _imageView[i].userInteractionEnabled = YES;
            
            _imageView[i].layer.transform = CATransform3DIdentity;
            UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
            [_imageView[i] addGestureRecognizer:pinchGestureRecognizer];
            [pinchGestureRecognizer release];
            
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [_imageView[i] addGestureRecognizer:tapGestureRecognizer];
            [tapGestureRecognizer release];
            [_scrollView addSubview:_imageView[i]];
        }
    }
    return self;
}
#pragma mark - 设置滚动图片视图的图片地址
- (void)setImageShowViewBigImage:(NSArray*)imagesArray
{
    for (int i = 0 ; i<[imagesArray count]; i++) {
        
        [_imageView[i] setImageURLString:[imagesArray[i] objectForKey:@"originalUrl"]];
    }
}

- (void)closeButtonClick:(id)sender
{
    [_delegate closeImageShowView];
}

- (void)pageControlValueChanged:(id)sender
{
    [_scrollView setContentOffset:CGPointMake(_pageControl.currentPage * self.frame.size.width, 0)];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0.0)
    {
        _currentPageNumLabel.text = @"1";
        _pageControl.currentPage = 0;
    }
    else if (scrollView.contentOffset.x == self.frame.size.width*1)
    {
        _currentPageNumLabel.text = @"2";
        _pageControl.currentPage = 1;
    }
    else if (scrollView.contentOffset.x == self.frame.size.width*2)
    {
        _currentPageNumLabel.text = @"3";
        _pageControl.currentPage = 2;
    }
    else if (scrollView.contentOffset.x == self.frame.size.width*3)
    {
        _currentPageNumLabel.text = @"4";
        _pageControl.currentPage = 3;
    }
    else if (scrollView.contentOffset.x == self.frame.size.width*4)
    {
        _currentPageNumLabel.text = @"5";
        _pageControl.currentPage = 4;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (UIView *imageView in scrollView.subviews){
        return imageView;
    }
    return nil;
}

-(void)pinch:(UIGestureRecognizer*)gestureRecognizer
{
    UIPinchGestureRecognizer *pinchGestureRecognizer = (UIPinchGestureRecognizer *)gestureRecognizer;
    CGFloat scale  = pinchGestureRecognizer.scale;
    NSLog(@"scale = %f",scale);
    CATransform3D transform = pinchGestureRecognizer.view.layer.transform;
    transform = CATransform3DScale(transform, scale, scale, 1);
    
    pinchGestureRecognizer.view.layer.transform = transform;
    pinchGestureRecognizer.scale = 1;
}

-(void)tap:(UIGestureRecognizer*)gestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)gestureRecognizer;
    tapGestureRecognizer.view.layer.transform = CATransform3DIdentity;
}


-(void)dealloc
{
    [_scrollView release];
    _scrollView = nil;
    [_closeButton release];
    _closeButton = nil;
    [_pageNumLabel release];
    _pageNumLabel = nil;
    [_currentPageNumLabel release];
    _currentPageNumLabel = nil;

    for (int i = 0; i<5; i++) {
        [_imageView[i] release];
        _imageView[i] = nil;
    }
    [super dealloc];
}
@end
