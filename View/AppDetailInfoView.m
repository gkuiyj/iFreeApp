//
//  AppDetailInfoView.m
//  iFreeApp
//
//  Created by wangkai on 14-5-11.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppDetailInfoView.h"
#import "UIImageView+UIImageView_WebImage.h"
#import "AppDetailInfoViewController.h"

@implementation AppDetailInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self UIConfig];
    }
    return self;
}

-(void)UIConfig
{
    _appIdLabel = [[UILabel alloc]init];
    [_appIdLabel setHidden:YES];
    _appItunesLabel = [[UILabel alloc]init];
    [_appItunesLabel setHidden:YES];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, 307, 256)];
    _imageView.image = [UIImage imageNamed:@"大框.png"];
    _imageView.userInteractionEnabled = YES;

    [self addSubview:_imageView];
    
    _appImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,77,78)];
    [_imageView addSubview:_appImageView];
    
    _appNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 3, 200, 25)];
    _appNameLabel.font = [UIFont systemFontOfSize:17];
    [_appNameLabel setTextColor:[UIColor blackColor]];
    [_imageView addSubview:_appNameLabel];
    
    _lastPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 200, 30)];
    _lastPriceLabel.font = [UIFont systemFontOfSize:14];
    [_lastPriceLabel setTextColor:[UIColor grayColor]];
    [_imageView addSubview:_lastPriceLabel];
    
    _appSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, 200, 30)];
    _appSizeLabel.font = [UIFont systemFontOfSize:14];
    [_appSizeLabel setTextColor:[UIColor grayColor]];
    [_imageView addSubview:_appSizeLabel];
    
    _categoryNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 100, 30)];
    _categoryNameLabel.font = [UIFont systemFontOfSize:14];
    [_categoryNameLabel setTextColor:[UIColor grayColor]];
    [_imageView addSubview:_categoryNameLabel];
    
    _starCurrentLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 60, 100, 30)];
    _starCurrentLabel.font = [UIFont systemFontOfSize:14];
    [_starCurrentLabel setTextColor:[UIColor grayColor]];
    [_imageView addSubview:_starCurrentLabel];
    
    //按钮背景
    [_buttonImageView = [UIImageView alloc]initWithFrame:CGRectMake(3, 100, 300, 30)];
    _buttonImageView.userInteractionEnabled = YES;
    //_buttonImageView.image = [UIImage imageNamed:@"6.应用详情_0.png"];
    
    _buttonShare = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 98, 30)];
    [_buttonShare setTitle:@"分享" forState:UIControlStateNormal];
    [_buttonShare addTarget:self action:@selector(buttonClickDown:) forControlEvents:UIControlEventTouchDown];
    [_buttonShare addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonImageView addSubview:_buttonShare];
    
    _lineImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(99, 0, 1, 30)];
    _lineImage1.image = [UIImage imageNamed:@"线.png"];
    [_buttonImageView addSubview:_lineImage1];
    [_lineImage1 release];
    
    _buttonCollect = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 98, 30)];
    [_buttonCollect setTitle:@"收藏" forState:UIControlStateNormal];
    [_buttonCollect addTarget:self action:@selector(buttonClickDown:) forControlEvents:UIControlEventTouchDown];
    [_buttonCollect addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonImageView addSubview:_buttonCollect];
    
    _lineImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(199, 0, 1, 30)];
    _lineImage2.image = [UIImage imageNamed:@"线.png"];
    [_buttonImageView addSubview:_lineImage2];
    [_lineImage2 release];
    
    _buttonDown = [[UIButton alloc]initWithFrame:CGRectMake(200, 0, 100, 30)];
    [_buttonDown setTitle:@"下载" forState:UIControlStateNormal];
    [_buttonDown addTarget:self action:@selector(buttonClickDown:) forControlEvents:UIControlEventTouchDown];
    [_buttonDown addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonImageView addSubview:_buttonDown];
    
    [_imageView addSubview:_buttonImageView];
    
    _imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(2, 130, 295, 70)];
    _imageScrollView.contentSize = CGSizeMake(300, 70);
    _imageScrollView.contentOffset = CGPointMake(0, 0);
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.directionalLockEnabled = YES;
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    [_imageView addSubview:_imageScrollView];
    
    for (int i = 0; i<5; i++) {
        _imageSmallUrl[i] = [[WKImageView alloc]initWithFrame:CGRectMake(5+i*60, 5, 55, 60)];
        _imageSmallUrl[i].userInteractionEnabled = YES;
        _imageSmallUrl[i].tag = i;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        tapGestureRecognizer.numberOfTouchesRequired = 1;
        [_imageSmallUrl[i] addGestureRecognizer:tapGestureRecognizer];
        [tapGestureRecognizer release];
        
        [_imageScrollView addSubview:_imageSmallUrl[i]];
    }
    
    _appDiscription = [[UILabel alloc]initWithFrame:CGRectMake(5, 181, 295, 80)];
    _appDiscription.font = [UIFont systemFontOfSize:12];
    _appDiscription.numberOfLines = 3;
    [_imageView addSubview:_appDiscription];
    
    _imageView4PlaceApp = [[UIImageView alloc]initWithFrame:CGRectMake(10, 330, 307,94)];
    _imageView4PlaceApp.userInteractionEnabled = YES;
    _imageView4PlaceApp.image = [UIImage imageNamed:@"大框.png"];
    _imageView4PlaceApp.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView4PlaceApp];
    
    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 80,15)];
//    _labelTitle.backgroundColor = [UIColor greenColor];
//    _labelTitle.text = @"附近的人在用:";
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.font = [UIFont systemFontOfSize:11];
    [_labelTitle setTextColor:[UIColor grayColor]];
    [_imageView4PlaceApp addSubview:_labelTitle];
    
    _placeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 2, 296,80)];
    _placeScrollView.contentSize = CGSizeMake(320, 80);
    _placeScrollView.contentOffset = CGPointMake(0, 0);
    _placeScrollView.pagingEnabled = YES;
    _placeScrollView.directionalLockEnabled = NO;
    _placeScrollView.showsHorizontalScrollIndicator = NO;
    [_imageView4PlaceApp addSubview:_placeScrollView];
    
    for (int i=0; i<5; i++)
    {
        _placeAppImageView[i] = [[WKImageView alloc]initWithFrame:CGRectMake(10+i*60, 22, 40, 40)];
        [_placeAppImageView[i] addTarget:self action:@selector(placeAppClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_placeScrollView addSubview:_placeAppImageView[i]];
        
        _placeAppName[i] = [[UILabel alloc]initWithFrame:CGRectMake(5+i*60, 60, 55, 26)];
        _placeAppName[i].font = [UIFont systemFontOfSize:11];
        _placeAppName[i].textAlignment = NSTextAlignmentCenter;
        [_placeScrollView addSubview:_placeAppName[i]];
    }
}
//按钮按下时改变背景颜色
-(void)buttonClickDown:(id)sender
{
    UIButton *button = sender;
    if (button == _buttonShare)
    {
        _buttonShare.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xuanzhong.png"]];
    }
    else if (button == _buttonCollect)
    {
        _buttonCollect.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xuanzhong.png"]];
    }
    else if (button == _buttonDown)
    {
        _buttonDown.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xuanzhong.png"]];
    }
}

-(void)buttonClick:(id)sender
{
    UIButton *button = sender;
    if (button == _buttonShare)
    {
        _buttonShare.backgroundColor = [UIColor clearColor];
        _shareActionSheet = [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新浪微薄" otherButtonTitles:@"微信好友",@"微信圈子",@"邮件",@"短信", nil];
        [_shareActionSheet showInView:self];
    }
    else if (button == _buttonCollect)
    {
        _buttonCollect.backgroundColor = [UIColor clearColor];
        NSLog(@"app %@ 收藏数加1",_appIdLabel.text);
    }
    else if (button == _buttonDown)
    {
        _buttonDown.backgroundColor = [UIColor clearColor];
         NSLog(@"跳转到itunes:%@",_appItunesLabel.text); //跳转到itunes
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_appItunesLabel.text]];
    }
}

//点击手势,点击图片时显示大截图
-(void)imageTap:(UIGestureRecognizer*)gestureRecognizer
{
    [_delegate showImageShowView:gestureRecognizer.view.tag];
}

//点击附近的app，跳转到app详情页
-(void)placeAppClicked:(id)sender
{
    WKImageView *palceAppImageView = (WKImageView*)sender;
    NSString *placeAppId = [NSString stringWithFormat:@"%d", palceAppImageView.tag];
    
    if (![placeAppId isEqualToString:_appIdLabel.text])
    {
        [[AppDetailInfoViewController shareAppDetailInfoViewController] showPalceAppDetailInfo:placeAppId];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"选中了%d",buttonIndex);
}

#pragma mark - fillData
- (void)fillData:(AppDetailInfoModel*)appModel
{
    if (appModel != nil) {
        [_appIdLabel setText:appModel.appId];
        [_appItunesLabel setText:appModel.itunesUrl];
        [_appNameLabel setText:appModel.appName];
        [_appImageView setImageURLString:appModel.appIcon];
        [_lastPriceLabel setText:[NSString stringWithFormat:@"原价: ￥%.2f",appModel.lastPrice]];
        [_appSizeLabel setText:[NSString stringWithFormat:@"大小: %@",appModel.appSize]];
        [_categoryNameLabel setText:[NSString stringWithFormat:@"类型: %@",appModel.categoryName]];
        [_starCurrentLabel setText:[NSString stringWithFormat:@"评分: %.1f",appModel.starCurrent]];

        _buttonImageView.image = [UIImage imageNamed:@"6.应用详情_0.png"];
        
        _labelTitle.backgroundColor = [UIColor greenColor];
        _labelTitle.text = @"附近的人在用:";
        
        for (int i = 0 ; i<[appModel.photos count]; i++) {
            [_imageSmallUrl[i] setUrlString:[appModel.photos[i] objectForKey:@"smallUrl"]];
        }
        
        [_appDiscription setText:[NSString stringWithFormat:@"%@",appModel.appDiscription]];
        
        //附近app信息
        for (int i = 0 ; i<[appModel.placeApps count]; i++)
        {
            _placeAppImageView[i].tag = [[appModel.placeApps[i] objectForKey:@"applicationId"] intValue];
            _placeAppImageView[i].urlString = [appModel.placeApps[i] objectForKey:@"iconUrl"];
            [_placeAppName[i] setText:[appModel.placeApps[i] objectForKey:@"name"]];
        }
        [self reloadInputViews];
    }
    
}

- (void)dealloc
{
    [_appIdLabel release];
    _appIdLabel = nil;
    [_appItunesLabel release];
    _appItunesLabel = nil;
    [_imageView release];
    _imageView = nil;
    [_appImageView release];
    _appImageView = nil;
    [_appNameLabel release];
    _appNameLabel = nil;
    [_lastPriceLabel release];
    _lastPriceLabel = nil;
    [_priceTrendLabel release];
    _priceTrendLabel = nil;
    [_categoryNameLabel release];
    _categoryNameLabel = nil;
    [_appSizeLabel release];
    _appSizeLabel = nil;
    [_starCurrentLabel release];
    _starCurrentLabel = nil;
    [_buttonImageView release];
    _buttonImageView = nil;
    [_buttonShare release];
    _buttonShare = nil;
    [_buttonCollect release];
    _buttonCollect = nil;
    [_buttonDown release];
    _buttonDown = nil;
    [_lineImage1 release];
    _lineImage1 = nil;
    [_lineImage2 release];
    _lineImage2 = nil;
    [_shareActionSheet release];
    _shareActionSheet = nil;
    [_imageScrollView release];
    _imageScrollView = nil;
    for (int i=0; i<5; i++) {
        [_imageSmallUrl[i] release];
        _imageSmallUrl[i] = nil;
        [_placeAppImageView[i] release];
        _placeAppImageView[i] = nil;
        [_placeAppName[i] release];
        _placeAppName[i] = nil;
    }
    [_appDiscription release];
    _appDiscription = nil;
    [_imageView4PlaceApp release];
    _imageView4PlaceApp = nil;
    [_placeScrollView release];
    _placeScrollView = nil;
    [_labelTitle release];
    _labelTitle = nil;
    [super dealloc];
}

@end
