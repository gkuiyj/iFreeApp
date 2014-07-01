//
//  iFreeApp
//
//  Created by wangkai on 14-5-23.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "AppLog.h"

static AppLog *g_appLog = nil;

void AppLogMessage(AppLogLevel level, NSString* message, ...)
{
    if( level <= [[AppLog sharedAppLog] level] )
	{
		va_list argList;
		va_start(argList, message);
		NSString *formattedMessage = [[NSString alloc] initWithFormat:message arguments:argList];
		[[AppLog sharedAppLog] logMessage:formattedMessage level:level];
        [formattedMessage release];
		va_end(argList);
	}
}

@implementation AppLog

+ (AppLog *)sharedAppLog
{
    if (g_appLog == nil)
    {
        g_appLog = [[AppLog alloc] init];
    }
    return g_appLog;
}

- (void)dealloc
{
    self.isStarted = NO;
    
    [_thread release];
    _thread = nil;
    
    [_theLevelStringArray release];
    _theLevelStringArray = nil;
    
    [_dateFormatter release];
    _dateFormatter = nil;
    
    [_logDirectory release];
    _logDirectory = nil;
    
    [_logName release];
    _logName = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _theLevelStringArray = [[NSArray alloc] initWithObjects:@"严重错误", @"错误", @"警告", @"信息", @"调试信息", nil];
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        
        _logDirectory = [[NSString stringWithFormat:@"%@/Library/Log", NSHomeDirectory()] retain];
        
        _logName = [[NSString stringWithFormat:@"日志文件"] retain];
        
        _level = AppLogLevelDebug;
    }
    return self;
}

/**
 *  开始记录日志
 */
- (void)startLogging
{
    [self removeOldLogs];
    
    _isStarted = YES;
    
    if (_fileHandle == nil)
    {
        NSFileManager *fm = [NSFileManager defaultManager];
		BOOL canCreateFile = YES;
		BOOL isDirectory;
		
        //创建目录
		if ( ! [fm fileExistsAtPath:_logDirectory isDirectory:&isDirectory] )
		{
			NSError *error;
			if ( ! [fm createDirectoryAtPath:_logDirectory withIntermediateDirectories:YES attributes:nil error:&error] )
			{
				NSLog(@"ERROR: Could not create log file: %@", error);
				canCreateFile = NO;
			}
		}
		
        //创建文件并打开文件
		if (canCreateFile)
		{
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"yyyy-MM-dd-HHmmss"];
            
			NSString *logBasename = [NSString stringWithFormat:@"%@-%@", _logName, [dateFormat stringFromDate:[NSDate date]]];
			NSString *logPath = [[_logDirectory stringByAppendingPathComponent:logBasename] stringByAppendingPathExtension:@"log"];
			
            [dateFormat release];
			if ([fm createFileAtPath:logPath contents:nil attributes:nil])
			{
				_fileHandle = [[NSFileHandle fileHandleForWritingAtPath:logPath] retain];
				if (_fileHandle == nil)
				{
					NSLog(@"ERROR: Could not open file for writing. Logging to console: %@", logPath);
				}
            }
        }
        
        if (_thread == nil)
        {
            // 后台线程打印
            _thread = [[NSThread alloc] initWithTarget:self selector:@selector(startRunLoop:) object:nil];
            [_thread start];
        }
    }
}

/**
 *  停止记录日志
 */
- (void)stopLogging
{
    self.isStarted = NO;
    
    //isStarted设置成NO后 发送消息给日志线程以退出消息循环，达到终止线程的目的。
    [self performSelector:@selector(sendStopMesage) onThread:_thread withObject:nil waitUntilDone:YES];
   /* while (! [[AppLog sharedAppLog] isFinished])
    {
        //sleep(0.1);
        AppLogMessage(_level, @"日志线程停止");
    }*/
}

- (void)sendStopMesage{}

- (BOOL)isFinished
{
    if (_thread == nil)
    {
        return YES;
    }
    else
    {
        return [_thread isFinished];
    }
}

/**
 *  开始记录日志
 */
- (void)logMessage:(NSString*)message level:(AppLogLevel)logLevel
{
    NSString *logMessage = nil;
    
    NSString *levelString = [_theLevelStringArray objectAtIndex:logLevel];
    
	if (_isStarted == YES)
	{
        logMessage = [[NSString alloc] initWithFormat:@"%@ - %@", levelString, message];
        
		if ([[NSThread currentThread] isEqual:_thread])
		{
			[self writeLogMessage:logMessage];
		}
		else
		{
			//线程的异步通信
			[self performSelector:@selector(writeLogMessage:) onThread:_thread withObject:logMessage waitUntilDone:NO];
		}
	}
	else
	{
		logMessage = [[NSString alloc] initWithFormat:@"%@ - %@", levelString, message];
		NSLog(@"(警告: QFLog is not running) %@", logMessage);
	}
    [logMessage release];
}


/**
 *  删除旧日志
 */
- (void)removeOldLogs
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    [fm removeItemAtPath:_logDirectory error:nil];
}

/**
 *  写日志
 *
 *  @param message 日志信息
 */
- (void)writeLogMessage:(NSString*)message
{
	NSString *dateString = [_dateFormatter stringFromDate:[NSDate date]];
	NSString *datedMessage = [NSString stringWithFormat:@"- %@ %@\n", dateString, message];
	
	NSLog(@"%@", message);
	
	if( _fileHandle != nil )
	{
		@try
		{
			[_fileHandle writeData:[datedMessage dataUsingEncoding:NSUTF8StringEncoding]];
		}
		@catch (NSException * e)
		{
			NSLog(@"写日志出现异常");
			NSLog(@"%@", message);
			_fileHandle = nil;
		}
	}
	else
	{
		NSLog(@"_fileHandle = nil  %@", message);
	}
}


- (void)startRunLoop:(id)sender
{
    do
    {   
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    } while (_isStarted);
    
    [_fileHandle closeFile];
    [_fileHandle release];
    _fileHandle = nil;
}

/**
 *  上传日志
 */
- (void)uploadLogs
{
    
}

@end
