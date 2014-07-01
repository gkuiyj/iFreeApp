//
//  WKImageView.h
//  iFreeApp
//
//  Created by wangkai on 14-5-12.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKImageView : UIControl
{
    UIImageView     *_imageView;
    NSString        *_urlString;
    id  _target;
    SEL _action;
}
@property(nonatomic,retain,readwrite)UIImage *image;
@property(copy, nonatomic,readwrite)NSString *urlString;

@end
