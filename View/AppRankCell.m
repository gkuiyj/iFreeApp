//
//  AppRankCell.m
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppRankCell.h"
#import "UIImageView+UIImageView_WebImage.h"

@implementation AppRankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self uiConfig];
        
        //设置cell的背景视图(处于常规状态下的)
        UIView *bgView  = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,100)];
        bgView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = bgView;
        [bgView release];
        
        //设置cell处于选中状态下的背景视图
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320,100)];
        selectView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
        self.selectedBackgroundView = selectView;
        [selectView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - TableCell UI 布局
- (void)uiConfig{
    _appIdLabel = [[UILabel alloc]init];
    [_appIdLabel setHidden:YES];
    
    _appImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,60,60)];
    [self.contentView addSubview:_appImageView];
    
    _appNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 200, 30)];
    _appNameLabel.font = [UIFont systemFontOfSize:17];
    [_appNameLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_appNameLabel];
    
    _appLastPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 25, 100, 30)];
    _appLastPriceLabel.font = [UIFont systemFontOfSize:14];
    [_appLastPriceLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appLastPriceLabel];
    
    _lineLabel = [[[UILabel alloc]initWithFrame:CGRectMake(240, 40, 53, 2)]autorelease];
    _lineLabel.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4];
    [self.contentView addSubview:_lineLabel];
    
    _appStarLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 25, 100, 30)];
    _appStarLabel.font = [UIFont systemFontOfSize:14];
    [_appStarLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appStarLabel];
    
    for (int i = 0; i<5; i++) {
        _starImageView[i] = [[UIImageView alloc]initWithFrame:CGRectMake(80+i*15,55,14,14)];
        [self.contentView addSubview:_starImageView[i]];
    }
    
    _appCategoryNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 45, 80, 30)];
    _appCategoryNameLabel.font = [UIFont systemFontOfSize:14];
    [_appCategoryNameLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appCategoryNameLabel];
    
    _appShareCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 80, 30)];
    _appShareCountLabel.font = [UIFont systemFontOfSize:14];
    [_appShareCountLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appShareCountLabel];
    
    _appCollectCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 80, 30)];
    _appCollectCountLabel.font = [UIFont systemFontOfSize:14];
    [_appCollectCountLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appCollectCountLabel];
    
    _appDownloadCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 70, 100, 30)];
    _appDownloadCountLabel.font = [UIFont systemFontOfSize:14];
    [_appDownloadCountLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appDownloadCountLabel];
}

#pragma mark - 给TabelCell 中的控件填充数据
- (void)fillData
{
    if (_appRankModel) {
        _appIdLabel.text = _appRankModel.appId;
        
        float n = _appRankModel.starCurrent;    //星数
        int m = _appRankModel.starCurrent/1;    //星数整数部分
        UIImage *image0 = [UIImage imageNamed:@"主页_14.png"];    //全星
        UIImage *image1 = [UIImage imageNamed:@"主页_15.png"];    //半星
        UIImage *image2 = [UIImage imageNamed:@"主页_16.png"];    //无星
        
        for (int i=0; i<5; i++)
        {
            if (i < m)  //如果星数大于当前位置i 显示全星
            {
                _starImageView[i].image = image0;
            }
            else if (i == m)    //第i个位置 等于星数的整数
            {
                if (n > m)  //如果星数大于其整数部分，显示半星
                {
                    _starImageView[i].image = image1;
                }
                else    //否则显示无星
                {
                    _starImageView[i].image = image2;
                }
            }
            else      //星数小于当前位置i  显示无星
            {
                _starImageView[i].image = image2;
            }
        }
        
        NSString *type = _appRankModel.appType;
        if ([type isEqualToString:@"Free"]) {
            _lineLabel.hidden = YES;
        }
        
        [_appImageView setImageURLString:_appRankModel.appIcon];
        _appNameLabel.text =  _appRankModel.appName;
        _appStarLabel.text = [NSString stringWithFormat:@"评分:%.2f分",_appRankModel.starCurrent];
        _appCategoryNameLabel.text = _appRankModel.categoryName;
        _appLastPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",_appRankModel.lastPrice];
        _appShareCountLabel.text = [NSString stringWithFormat:@"分享 : %d次",_appRankModel.appShareCount];
        _appCollectCountLabel.text = [NSString stringWithFormat:@"收藏 : %d次",_appRankModel.appCollectCount];
        _appDownloadCountLabel.text = [NSString stringWithFormat:@"下载 : %d次",_appRankModel.appDownloadCount];
    }
}

#pragma mark - 析构函数
-(void)dealloc
{
    for (int i = 0; i<5; i++) {
        [_starImageView[i] release];
        _starImageView[i] = nil;
    }
    
    [_appImageView release];
    _appImageView = nil;
    [_appNameLabel release];
    _appNameLabel = nil;
    [_appCategoryNameLabel release];
    _appCategoryNameLabel = nil;
    [_appStarLabel release];
    _appStarLabel  = nil;
    [_appLastPriceLabel release];
    _appLastPriceLabel = nil;
    [_lineLabel release];
    _lineLabel = nil;
    [_appShareCountLabel release];
    _appShareCountLabel = nil;
    [_appCollectCountLabel release];
    _appCollectCountLabel = nil;
    [_appDownloadCountLabel release];
    _appDownloadCountLabel = nil;
    [super dealloc];
}
@end
