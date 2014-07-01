//
//  WKHTTPRequest.h
//  testiOS_Net_json
//
//  Created by wangkai on 14-5-6.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishBlock)(NSData *data);
typedef void(^FailedBlock)(NSError *error);

@interface WKHTTPRequest : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableData   *_mData;
}
@property(copy,nonatomic)NSString *url;
@property(copy,nonatomic)FinishBlock finishBlock;
@property(copy,nonatomic)FailedBlock failedBlock;

-(void)startRequest;
@end
