//
//  AppCategoryCell.m
//  iFreeApp
//
//  Created by wangkai on 14-5-18.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppCategoryCell.h"
#import "UIImageView+UIImageView_WebImage.h"

@implementation AppCategoryCell

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

#pragma mark - Cell UI布局函数
- (void)uiConfig
{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    [self.contentView addSubview:_imageView];
    
    _categoryCNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 200, 40)];
    _categoryCNameLabel.font = [UIFont systemFontOfSize:17];
    [_categoryCNameLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_categoryCNameLabel];
    
    _categoryCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 45, 110, 30)];
    _categoryCountLabel.font = [UIFont systemFontOfSize:13];
    [_categoryCountLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_categoryCountLabel];
    
    _currentTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(190, 45, 130, 30)];
    _currentTextLabel.font = [UIFont systemFontOfSize:13];
    [_currentTextLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_currentTextLabel];
    
}


#pragma mark - 给TabelCell 中的控件填充数据
- (void)fillData:(NSString*)categoryType
{
    if (_appCategoryModel) {
        [_imageView setImageURLString:_appCategoryModel.picUrl];
        
        _categoryCNameLabel.text = _appCategoryModel.categoryCName;
        _categoryCountLabel.text = [NSString stringWithFormat:@"共%d款应用,",_appCategoryModel.categoryCount];
        
        if ([categoryType isEqualToString:@"limit"]) {
            _currentTextLabel.text = [NSString stringWithFormat:@"其中限免%d款",_appCategoryModel.limited];
        }
        else if ([categoryType isEqualToString:@"down"])
        {
            _currentTextLabel.text = [NSString stringWithFormat:@"其中降价%d款",_appCategoryModel.down];
        }
        else if ([categoryType isEqualToString:@"free"])
        {
            _currentTextLabel.text = [NSString stringWithFormat:@"其中免费%d款",_appCategoryModel.free];
        }
        else if ([categoryType isEqualToString:@"rank"])
        {
            _currentTextLabel.text = [NSString stringWithFormat:@"其中热榜前300款"];
        }
    }
}

- (void)dealloc
{
    [_appCategoryModel release];
    _appCategoryModel = nil;
    [_imageView release];
    _imageView = nil;
    [_categoryCNameLabel release];
    _categoryCNameLabel = nil;
    [_categoryCountLabel release];
    _categoryCountLabel = nil;
    [_currentTextLabel release];
    _currentTextLabel = nil;
    [super dealloc];
}
@end
