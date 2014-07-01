//
//  WKHTTPRequest.m
//  testiOS_Net_json
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "WKHTTPRequest.h"
#import "WKCachedDownloadManager.h"

@implementation WKHTTPRequest

-(id)init
{
   self = [super init];
    if (self) {
        _mData = [[NSMutableData alloc]init];
    }
    return self;
}

- (void)startRequest
{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    
    //NSMutableURLRequest *mutableURLRequest = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]] autorelease];
    //[mutableURLRequest setTimeoutInterval:30];
    
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    NSCachedURLResponse *cachedURLResponse = [urlCache cachedResponseForRequest:request];
    
    //本地有缓存
    if (cachedURLResponse != nil)
    {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)[cachedURLResponse response];
        
        NSString *cacheControl = [[response allHeaderFields] valueForKey:@"Cache-Control"];
        
        unsigned long long maxAge = [[cacheControl substringFromIndex:strlen("max-age=")] longLongValue];
        
        if (maxAge == 0) {
            maxAge = 600;    //如果服务端未设置过期时间，则默认设置为600秒过期
        }
        
        time_t cacheTime = [[WKCachedDownloadManager shareWKCachedDownloadManager] cacheTimeWithURLString:self.url];
        
        time_t nowTime = time(0);
        
        //缓存过期
        if (nowTime - cacheTime > maxAge)
        {
            //发起异步请求 立刻返回 之后异步调用代码块finishBlock
            [NSURLConnection connectionWithRequest:request delegate:self];
            //[mutableURLRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
            //[NSURLConnection connectionWithRequest:mutableURLRequest delegate:self];
            [self retain];
        }
        else//缓存没过期、直接同步调用代码块finishBlock
        {
            self.finishBlock([cachedURLResponse data]);
        }
    }
    else
    {
        //发起异步请求 立刻返回 之后异步调用代码块finishBlock
        [NSURLConnection connectionWithRequest:request delegate:self];
        //[mutableURLRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        //[NSURLConnection connectionWithRequest:mutableURLRequest delegate:self];
        [self retain];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.finishBlock(_mData);
    
    [[WKCachedDownloadManager shareWKCachedDownloadManager] setURLString:self.url cacheTime:time(0)];
    [self release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.failedBlock(error);
    [self release];
}

-(void)dealloc
{
    [_mData release];
    self.url = nil;
    [super dealloc];
}
@end
