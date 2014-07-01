//
//  WKCachedDownloadManager.h
//  iFreeApp
//
//  Created by wangkai on 14-6-19.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKCachedDownloadManager : NSObject
{
    //记录缓存数据的字典
    NSMutableDictionary *_cacheDictionary;
    
    //缓存数据字典的路径
    NSString *_cacheDictionaryPath;
}

+ (WKCachedDownloadManager *)shareWKCachedDownloadManager;

- (void)setURLString:(NSString *)urlString cacheTime:(time_t)time;

- (time_t)cacheTimeWithURLString:(NSString *)urlString;

- (void)saveCacheDictionary;
@end
