//
//  WKCachedDownloadManager.m
//  iFreeApp
//
//  Created by wangkai on 14-6-19.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "WKCachedDownloadManager.h"

#import <pthread.h>

static pthread_mutex_t g_mutex = PTHREAD_MUTEX_INITIALIZER;

static WKCachedDownloadManager *g_cachedDownloadManager = nil;

@implementation WKCachedDownloadManager
+ (WKCachedDownloadManager *)shareWKCachedDownloadManager
{
    pthread_mutex_lock(&g_mutex);
    if (g_cachedDownloadManager == nil)
    {
        g_cachedDownloadManager = [[WKCachedDownloadManager alloc] init];
    }
    pthread_mutex_unlock(&g_mutex);
    return g_cachedDownloadManager;
}



- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _cacheDictionaryPath = [[NSString stringWithFormat:@"%@/Library/cacheDictionary.cache", NSHomeDirectory()] retain];
        
        NSFileManager  *fileManager = [NSFileManager defaultManager];
        
        if (! [fileManager isExecutableFileAtPath:_cacheDictionaryPath])
        {
            [fileManager createFileAtPath:_cacheDictionaryPath contents:nil attributes:nil];
        }
        
        NSData *jsonData = [NSData dataWithContentsOfFile:_cacheDictionaryPath];
        
        _cacheDictionary = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] retain];
        
        if (_cacheDictionary == nil)
        {
            _cacheDictionary = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (void)setURLString:(NSString *)urlString cacheTime:(time_t)time
{
    [_cacheDictionary setValue:[NSString stringWithFormat:@"%ld", (long)time] forKey:urlString];
}

- (time_t)cacheTimeWithURLString:(NSString *)urlString
{
    NSString *timeString = [_cacheDictionary valueForKey:urlString];
    
    if (timeString == nil)
    {
        return 0;
    }
    else
    {
        return (time_t)[timeString longLongValue];
    }
}

- (void)saveCacheDictionary
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_cacheDictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    [jsonData writeToFile:_cacheDictionaryPath atomically:YES];
}

- (void)dealloc
{
    [self saveCacheDictionary];
    
    [_cacheDictionary release];
    [_cacheDictionaryPath release];
    
    [super dealloc];
}
@end
