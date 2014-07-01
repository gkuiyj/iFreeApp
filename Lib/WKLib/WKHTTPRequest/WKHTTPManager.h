//
//  WKHTTPManager.h
//  testiOS_Net_json
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKHTTPRequest.h"

@interface WKHTTPManager : NSObject

/**
 *  该函数实现了HTTP的异步请求功能
 *
 *  @param url    链接地址
 *  @param finish 异步下载完成并成功后要回调的代码块
 *  @param failed 异步下载失败后要回调的代码块
 */
+ (void)requestWithUrl:(NSString*)url Finish:(FinishBlock)finish Failed:(FailedBlock)failed;

@end
