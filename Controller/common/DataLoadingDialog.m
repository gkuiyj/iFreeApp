//
//  DataLoadingDialog.m
//  iFreeApp
//
//  Created by wangkai on 14-6-8.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "DataLoadingDialog.h"

@implementation DataLoadingDialog


-(void)setText:(NSString *)text
{
    _label.text = text;
}

-(NSString*)text
{
    return [[_label.text copy]autorelease];
}

-(id)initWithFrame:(CGRect)frame
{
    frame.size.width = 200;
    frame.size.height = 80;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:0.7f];
        self.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        self.layer.cornerRadius = 8;
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
        _label.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        _label.font = [UIFont systemFontOfSize:13];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        _button.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/4.0*3);
        [_button setTitle:@"取 消" forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicatorView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/4.0);
        _activityIndicatorView.color = [UIColor whiteColor];
        _activityIndicatorView.hidesWhenStopped = NO;
        
        [self addSubview:_activityIndicatorView];
    }
    return self;
}

-(void)layoutSubviews
{
    _label.center = CGPointMake(self.frame.size.width/2.0,self.frame.size.height/2.0);
    _activityIndicatorView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/4.0);
    _button.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/4.0*3);
}

-(void)cancelButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(DataLoadingDialogDidCancel:)])
    {
        [self.delegate DataLoadingDialogDidCancel:self];
    }
}

-(void)startActivity
{
    [_activityIndicatorView startAnimating];
}

-(void)stopActivity
{
    [_activityIndicatorView stopAnimating];
}


-(void)dealloc
{
    [_activityIndicatorView release];
    _activityIndicatorView  = nil;
    [_label release];
    _label = nil;
    [_button release];
    _button = nil;
    [super dealloc];
}

@end
