//
//  UIImageView+UIImageView_WebImage.m
//  iFreeApp
//
//  Created by wangkai on 14-5-7.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "UIImageView+UIImageView_WebImage.h"
#import "WKHTTPManager.h"

@implementation UIImageView (UIImageView_WebImage)

- (void)setImageURLString:(NSString *)url
{
    UIActivityIndicatorView *_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
    _activityIndicatorView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [self addSubview:_activityIndicatorView];
    
    [_activityIndicatorView startAnimating];
    
    [WKHTTPManager requestWithUrl:url Finish:^(NSData *data) {
        
        [_activityIndicatorView removeFromSuperview];
        [_activityIndicatorView release];
        
        self.image = [UIImage imageWithData:data];
        
    } Failed:^(NSError *error) {
        
        [_activityIndicatorView removeFromSuperview];
        [_activityIndicatorView release];
    }];
    
}
@end
