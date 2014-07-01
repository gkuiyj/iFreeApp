//
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum AppLogLevel
{
    AppLogLevelFail = 0,
    AppLogLevelError,
    AppLogLevelWarning,
    AppLogLevelInfo,
    AppLogLevelDebug
} AppLogLevel;

void AppLogMessage(AppLogLevel level, NSString* message, ...);

@interface AppLog : NSObject
{
    AppLogLevel _level;
    BOOL _isStarted;
    NSThread *_thread;
    
    NSString* _logDirectory;//日志文件目录
    NSFileHandle *_fileHandle;//日志文件句柄
    NSString* _logName;//日志文件名
    
    NSArray *_theLevelStringArray;
    
    NSDateFormatter *_dateFormatter;
}

@property (nonatomic, readwrite, assign) AppLogLevel level;
@property (nonatomic, readwrite, assign) BOOL isStarted;

/**
 *  AppLog Singleton对象
 *
 *  @return AppLog对象
 */
+ (AppLog *)sharedAppLog;

/**
 *  开始记录日志
 */
- (void)startLogging;

/**
 *  停止记录日志
 */
- (void)stopLogging;

- (BOOL)isFinished;


/**
 *  开始记录日志
 */
- (void)logMessage:(NSString*)message level:(AppLogLevel)level;

/**
 *  删除旧日志
 */
- (void)removeOldLogs;

/**
 *  上传日志
 */
- (void)uploadLogs;


@end
