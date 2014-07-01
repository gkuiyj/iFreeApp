//
//  DetailInfoImageShowViewController.m
//  iFreeApp
//
//  Created by wangkai on 14-5-16.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "DetailInfoImageShowViewController.h"
#import "MainViewController.h"

@interface DetailInfoImageShowViewController ()

@end

@implementation DetailInfoImageShowViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)dealloc
{
    [self MY_viewDidUnLoad];
    [super dealloc];
}

- (void)MY_viewDidUnLoad
{
    [_detailInfoImageShowView release];
    _detailInfoImageShowView = nil;
    [_detailInfoImageShowViewPhotos release];
    _detailInfoImageShowViewPhotos = nil;
}

-(void)loadView
{
    [super loadView];
}

- (void)showDetailInfoImageShowView
{
    NSUInteger i = [_detailInfoImageShowViewPhotos count];
    _detailInfoImageShowView = [[DetailInfoImageShowView alloc]initWithFrame:self.view.bounds];
    _detailInfoImageShowView.delegate = self;
    [_detailInfoImageShowView setImageShowViewBigImage:_detailInfoImageShowViewPhotos];
    _detailInfoImageShowView.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*i, self.view.bounds.size.height-60);
    _detailInfoImageShowView.scrollView.contentOffset = CGPointMake(_selectedImageId*self.view.bounds.size.width, 0);
    _detailInfoImageShowView.pageNumLabel.text = [NSString stringWithFormat:@" of %d",i];
    _detailInfoImageShowView.pageControl.currentPage = _selectedImageId;
    _detailInfoImageShowView.pageControl.numberOfPages = i;
    _detailInfoImageShowView.currentPageNumLabel.text = [NSString stringWithFormat:@"%d",_selectedImageId+1];
    [self.view addSubview:_detailInfoImageShowView];
}

- (void)closeImageShowView
{
    [[MainViewController shareMainViewController] closeDetailInfoImageShowViewController];
}

- (void)removeDetailInfoImageShowView
{
    [_detailInfoImageShowView removeFromSuperview];
    [_detailInfoImageShowView release];
    _detailInfoImageShowView = nil;
}
@end
