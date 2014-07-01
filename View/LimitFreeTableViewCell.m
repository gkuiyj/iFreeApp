//
//  appproduct_tableviewcellCell.m
//  iFreeApp
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "LimitFreeTableViewCell.h"
#import "UIImageView+UIImageView_WebImage.h"

@implementation LimitFreeTableViewCell

#pragma mark - 构造函数
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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

#pragma mark - TableCell UI 布局
- (void)uiConfig{
    _appImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,60,60)];
    [self.contentView addSubview:_appImageView];
    
    _appNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 2, 200, 30)];
    _appNameLabel.font = [UIFont systemFontOfSize:17];
    [_appNameLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_appNameLabel];
    
    _appFreeTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 25, 150, 30)];
    _appFreeTimeLabel.font = [UIFont systemFontOfSize:14];
    [_appFreeTimeLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appFreeTimeLabel];
    
    _appPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 25, 100, 30)];
    _appPriceLabel.font = [UIFont systemFontOfSize:14];
    [_appPriceLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appPriceLabel];
    //设置价格上的删除线
    UILabel *lineLabel = [[[UILabel alloc]initWithFrame:CGRectMake(240, 40, 53, 2)]autorelease];
    lineLabel.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4];
    [self.contentView addSubview:lineLabel];
    
    for (int i = 0; i < 5; i++) {
        _starImageView[i] = [[UIImageView alloc]initWithFrame:CGRectMake(80+i*15,55,14,14)];
        [self.contentView addSubview:_starImageView[i]];
    }
    
    _appTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 45, 80, 30)];
    _appTypeLabel.font = [UIFont systemFontOfSize:14];
    [_appTypeLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_appTypeLabel];
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 给TabelCell 中的控件填充数据
- (void)fillData
{
    if (_limitFreeModel) {
        [_appImageView setImageURLString:_limitFreeModel.appIcon];
        float n = _limitFreeModel.starCurrent;
        int m = _limitFreeModel.starCurrent/1;
        UIImage *image0 = [UIImage imageNamed:@"主页_14.png"];
        UIImage *image1 = [UIImage imageNamed:@"主页_15.png"];
        UIImage *image2 = [UIImage imageNamed:@"主页_16.png"];
        
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
            
        _appNameLabel.text =  _limitFreeModel.appName;
        _appFreeTimeLabel.text = [NSString stringWithFormat:@"剩余:%@",_limitFreeModel.appFreeTime];
        _appTypeLabel.text = _limitFreeModel.appType;
        _appPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",_limitFreeModel.appPrice];
        _appShareCountLabel.text = [NSString stringWithFormat:@"分享 : %d次",_limitFreeModel.appShareCount];
        _appCollectCountLabel.text = [NSString stringWithFormat:@"收藏 : %d次",_limitFreeModel.appCollectCount];
        _appDownloadCountLabel.text = [NSString stringWithFormat:@"下载 : %d次",_limitFreeModel.appDownloadCount];
    }
}

#pragma mark - 析构函数
-(void)dealloc
{
    for (int i = 0 ; i < 5; i++) {
        [_starImageView[i] release];
        _starImageView[i] = nil;
    }
    
    [_appImageView release];
    _appImageView = nil;
    [_appNameLabel release];
    _appNameLabel = nil;
    [_appFreeTimeLabel release];
    _appFreeTimeLabel = nil;
    [_appPriceLabel release];
    _appPriceLabel = nil;
    [_appShareCountLabel release];
    _appShareCountLabel = nil;
    [_appCollectCountLabel release];
    _appCollectCountLabel = nil;
    [_appDownloadCountLabel release];
    _appDownloadCountLabel = nil;
    [super dealloc];
}
@end
