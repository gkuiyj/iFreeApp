//
//  AppSubjectCell.h
//  iFreeApp
//
//  Created by wangkai on 14-5-21.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSubjectModel.h"
/**
 *  专题信息TableViewCell
 */
@interface AppSubjectCell : UITableViewCell
{
    AppSubjectModel     *_appSubjectModel;
    
    UILabel         *_titleLabel;
    UILabel         *_lineLabel0;
    UIImageView     *_imgView;
    UIImageView     *_dscImgView;
    UILabel         *_dscLabel;
    
    UIButton        *_appButton[4];
    UIImageView     *_appImageView[4];
    UILabel         *_appNameLabel[4];
    UIImageView     *_appCommentImageView[4];
    UILabel         *_appCommentLabel[4];
    UIImageView     *_appDonloadsImageView[4];
    UILabel         *_appDonloadsLabel[4];
    UIImageView     *_appStarImageView[4][5];
    UILabel         *_lineLabel[4];
    
    UIButton        *_app1Button;
    UIImageView     *_app1ImageView;
    UILabel         *_app1NameLabel;
    UIImageView     *_app1CommentImageView;
    UILabel         *_app1CommentLabel;
    UIImageView     *_app1DonloadsImageView;
    UILabel         *_app1DonloadsLabel;
    UIImageView     *_app1StarImageView1;
    UIImageView     *_app1StarImageView2;
    UIImageView     *_app1StarImageView3;
    UIImageView     *_app1StarImageView4;
    UIImageView     *_app1StarImageView5;
    UILabel         *_lineLabel1;
    
    UIButton        *_app2Button;
    UIImageView     *_app2ImageView;
    UILabel         *_app2NameLabel;
    UIImageView     *_app2CommentImageView;
    UILabel         *_app2CommentLabel;
    UIImageView     *_app2DonloadsImageView;
    UILabel         *_app2DonloadsLabel;
    UIImageView     *_app2StarImageView1;
    UIImageView     *_app2StarImageView2;
    UIImageView     *_app2StarImageView3;
    UIImageView     *_app2StarImageView4;
    UIImageView     *_app2StarImageView5;
    UILabel         *_lineLabel2;
    
    UIButton        *_app3Button;
    UIImageView     *_app3ImageView;
    UILabel         *_app3NameLabel;
    UIImageView     *_app3CommentImageView;
    UILabel         *_app3CommentLabel;
    UIImageView     *_app3DonloadsImageView;
    UILabel         *_app3DonloadsLabel;
    UIImageView     *_app3StarImageView1;
    UIImageView     *_app3StarImageView2;
    UIImageView     *_app3StarImageView3;
    UIImageView     *_app3StarImageView4;
    UIImageView     *_app3StarImageView5;
    UILabel         *_lineLabel3;
    
    UIButton        *_app4Button;
    UIImageView     *_app4ImageView;
    UILabel         *_app4NameLabel;
    UIImageView     *_app4CommentImageView;
    UILabel         *_app4CommentLabel;
    UIImageView     *_app4DonloadsImageView;
    UILabel         *_app4DonloadsLabel;
    UIImageView     *_app4StarImageView1;
    UIImageView     *_app4StarImageView2;
    UIImageView     *_app4StarImageView3;
    UIImageView     *_app4StarImageView4;
    UIImageView     *_app4StarImageView5;
    UILabel         *_lineLabel4;
    
    UIView          *_lineView;
    
}
@property(nonatomic,retain,readwrite)AppSubjectModel *appSubjectModel;

- (void)fillData;
@end
