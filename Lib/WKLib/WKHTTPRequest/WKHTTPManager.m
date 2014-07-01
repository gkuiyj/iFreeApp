//
//  WKHTTPManager.m
//  testiOS_Net_json
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "WKHTTPManager.h"

@implementation WKHTTPManager


+(void)requestWithUrl:(NSString *)url Finish:(FinishBlock)finish Failed:(FailedBlock)failed
{
    WKHTTPRequest *request = [[[WKHTTPRequest alloc]init]autorelease];
    request.url = url;
    request.finishBlock = finish;
    request.failedBlock = failed;
    [request startRequest];
}
@end
