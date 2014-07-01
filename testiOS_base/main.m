//
//  main.m
//  testiOS_base
//
//  Created by wangkai on 14-4-30.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "AppLog.h"

void signalHandle(int sig)
{
    //程序因闪退
    AppLogMessage(AppLogLevelFail, @"程序闪退、信号值为 = %d", sig);
    
    //保留闪退信息到文件 程序下次启动时上传日志文件到服务器
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
    [defaluts setObject:@"是" forKey:@"是否闪退"];
    [defaluts synchronize];
    
    //停止日志线程
    [[AppLog sharedAppLog] stopLogging];
    
    sleep(3);
    
    exit(0);
}

int main(int argc, char * argv[])
{
    @autoreleasepool {
        
        NSLog(@"NSHomeDirectory() = %@", NSHomeDirectory());
        
        NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
        [defaluts setObject:@"否" forKey:@"是否闪退"];
        [defaluts synchronize];
        
        //打开日志线程并开始记录日志
        [[AppLog sharedAppLog] startLogging];
        
        for (int i=1; i<=31; i++)
        {
            /*if (i == SIGKILL || i == SIGSTOP)
             {
             continue;
             }*/
            signal(i, signalHandle);
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
