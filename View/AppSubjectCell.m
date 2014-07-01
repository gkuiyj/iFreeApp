//
//  AppSubjectCell.m
//  iFreeApp
//
//  Created by wangkai on 14-5-21.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppSubjectCell.h"
#import "UIImageView+UIImageView_WebImage.h"
#import "AppSubjectViewController.h"

@implementation AppSubjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置cell的背景视图(处于常规状态下的)
        UIView *bgView  = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,340)];
        bgView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:0.8];
        self.backgroundView = bgView;
        [bgView release];
        [self uiConfig];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
   // [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - TableCell UI 布局
- (void)uiConfig
{
    //self.backgroundColor = [UIColor colorWithRed:240/255.f green:245/255.f blue:245/255.f alpha:0.5];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 250, 30)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_titleLabel setTextColor:[UIColor blackColor]];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    
    _lineLabel0 = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 295, 1)];
    _lineLabel0.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_lineLabel0];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 48, 120, 185)];
    _imgView.backgroundColor = [UIColor whiteColor];
    _imgView.layer.borderWidth = 3;
    _imgView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.contentView addSubview:_imgView];
    
    for (int i = 0 ; i < 4; i++) {
        _appButton[i] = [[UIButton alloc]initWithFrame:CGRectMake(130, 42+i*55, 170, 50)];
        [_appButton[i] addTarget:self action:@selector(appButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_appButton[i] addTarget:self action:@selector(appButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_appButton[i]];
        
        _appImageView[i] = [[UIImageView alloc]initWithFrame:CGRectMake(7, 0, 45, 45)];
        [_appButton[i] addSubview:_appImageView[i]];
        
        _appNameLabel[i] = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 130, 13)];
        _appNameLabel[i].textAlignment = NSTextAlignmentLeft;
        _appNameLabel[i].font = [UIFont systemFontOfSize:13];
        [_appNameLabel[i] setTextColor:[UIColor darkGrayColor]];
        [_appButton[i] addSubview:_appNameLabel[i]];
        
        _appCommentImageView[i] = [[UIImageView alloc]initWithFrame:CGRectMake(57, 22, 12, 6)];
        _appCommentImageView[i].image = [UIImage imageNamed:@"11.png"];
        [_appButton[i] addSubview:_appCommentImageView[i]];
        
        _appCommentLabel[i] = [[UILabel alloc]initWithFrame:CGRectMake(75, 20, 50, 10)];
        _appCommentLabel[i].textAlignment = NSTextAlignmentLeft;
        _appCommentLabel[i].font = [UIFont systemFontOfSize:10];
        [_appCommentLabel[i] setTextColor:[UIColor darkGrayColor]];
        [_appButton[i] addSubview:_appCommentLabel[i]];
        
        _appDonloadsImageView[i] = [[UIImageView alloc]initWithFrame:CGRectMake(115, 22, 12, 6)];
        _appDonloadsImageView[i].image = [UIImage imageNamed:@"12.png"];
        [_appButton[i] addSubview:_appDonloadsImageView[i]];
        
        _appDonloadsLabel[i] = [[UILabel alloc]initWithFrame:CGRectMake(132, 20, 50, 10)];
        _appDonloadsLabel[i].textAlignment = NSTextAlignmentLeft;
        _appDonloadsLabel[i].font = [UIFont systemFontOfSize:10];
        [_appDonloadsLabel[i] setTextColor:[UIColor darkGrayColor]];
        [_appButton[i] addSubview:_appDonloadsLabel[i]];
        
        for (int j = 0; j < 5; j++) {
            _appStarImageView[i][j] = [[UIImageView alloc]initWithFrame:CGRectMake(58+13*j, 34, 12, 12)];
            [_appButton[i] addSubview:_appStarImageView[i][j]];
        }
        
        _lineLabel[i] = [[UILabel alloc]initWithFrame:CGRectMake(135, 92+55*i, 160, 1)];
        _lineLabel[i].backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_lineLabel[i]];
    }
    
    //描述信息
    _dscImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 270, 50, 50)];
    _dscImgView.backgroundColor = [UIColor whiteColor];
    _dscImgView.layer.borderWidth = 2;
    _dscImgView.layer.borderColor =[UIColor whiteColor].CGColor;
    [self.contentView addSubview:_dscImgView];
    
    _dscLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 260, 245, 60)];
    _dscLabel.font = [UIFont systemFontOfSize:12];
    [_dscLabel setTextColor:[UIColor darkGrayColor]];
    _dscLabel.numberOfLines = 3;
    [self.contentView addSubview:_dscLabel];
    
    //顶部白线
    _lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 6)];
    _lineView.backgroundColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.9];
    [self.contentView addSubview:_lineView];
    
}

#pragma mark - TableCell 填充数据
- (void)fillData
{
    if (_appSubjectModel) {
        _titleLabel.text = _appSubjectModel.title;
        [_imgView setImageURLString:_appSubjectModel.img];
        _dscLabel.text = _appSubjectModel.desc;
        [_dscImgView setImageURLString:_appSubjectModel.desc_img];
        
        for (int i = 0; i < 4; i++) {
            [_appImageView[i] setImageURLString: [_appSubjectModel.appInfoArray[i] objectForKey:@"iconUrl"]];
            _appNameLabel[i].text = [_appSubjectModel.appInfoArray[i] objectForKey:@"name"];
            _appCommentLabel[i].text = [[_appSubjectModel.appInfoArray[i] objectForKey:@"comment"] stringValue];
            _appDonloadsLabel[i].text = [_appSubjectModel.appInfoArray[i] objectForKey:@"downloads"];
            _appButton[i].tag = [[_appSubjectModel.appInfoArray[i] objectForKey:@"applicationId"] intValue];
            float n = [[_appSubjectModel.appInfoArray[i] objectForKey:@"starOverall"] floatValue];
            int m = n/1;
            UIImage *image0 = [UIImage imageNamed:@"主页_14.png"];
            UIImage *image1 = [UIImage imageNamed:@"主页_15.png"];
            UIImage *image2 = [UIImage imageNamed:@"主页_16.png"];
            for (int j=0; j < 5; j++)
            {
                if (j < m)  //如果星数大于当前位置i 显示全星
                {
                    _appStarImageView[i][j].image = image0;
                }
                else if (j == m)    //第i个位置 等于星数的整数
                {
                    if (n > m)  //如果星数大于其整数部分，显示半星
                    {
                        _appStarImageView[i][j].image = image1;
                    }
                    else    //否则显示无星
                    {
                        _appStarImageView[i][j].image = image2;
                    }
                }
                else      //星数小于当前位置i  显示无星
                {
                    _appStarImageView[i][j].image = image2;
                }
            }
        }
        
    }
    
}

- (void)appButtonTouchDown:(UIButton*)button
{
    //button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"选中.png"]];
}

- (void)appButtonClick:(UIButton*)button
{
    NSString *appid = [NSString stringWithFormat:@"%d",button.tag];
    [[AppSubjectViewController shareAppSubjectViewController] showAppDetailInfoViewController:appid];
}
@end
