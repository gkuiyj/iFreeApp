//
//  WKImageView.m
//  iFreeApp
//
//  Created by wangkai on 14-5-12.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "WKImageView.h"
#import "WKHTTPManager.h"

@implementation WKImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    _imageView.image = image;
}

@synthesize urlString = _urlString;

- (void)setUrlString:(NSString *)urlString
{
    [urlString retain];
    [_urlString release];
    _urlString = [urlString copy];
    //[urlString release];
    
    
    UIActivityIndicatorView *_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
    _activityIndicatorView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.9];;
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [self addSubview:_activityIndicatorView];
    
    [_activityIndicatorView startAnimating];
    
    [WKHTTPManager requestWithUrl:_urlString Finish:^(NSData *data) {
        
        [_activityIndicatorView removeFromSuperview];
        [_activityIndicatorView release];
        
        [self setImage: [UIImage imageWithData:data]];
        
    } Failed:^(NSError *error) {
        
        [_activityIndicatorView removeFromSuperview];
        [_activityIndicatorView release];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:self];
    }
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (controlEvents & UIControlEventTouchUpInside ) {
        _action = action;
        _target = target;
    }
}
@end
