//
//  MyUncaughtExceptionHandler.m
//  CrashProject
//
//  Created by Hosel on 2017/8/3.
//  Copyright © 2017年 Hosel. All rights reserved.
//

#import "MyUncaughtExceptionHandler.h"
#import "Tool.h"

NSString *applicationDocumentsDirectory(){
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

void UncaughtExceptionHandler(NSException * exception){
    /**
     *  获取异常崩溃信息
     */
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason];
    NSString * name = [exception name];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    
    //写入沙盒
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString *exceptionString = [NSString stringWithFormat:@"[文件名:%s] [函数名:%s] [行号:%d] [异常:%@]",__FILE__,__FUNCTION__,__LINE__,exception];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];//时间
    
    NSString *iOS_Version = [[UIDevice currentDevice] systemVersion];//iOS系统版本
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//app版本
    NSString *iPhoneType = [Tool getiPhoneType];//iPhone机型
    
    //发送邮件给开发者
    NSString *urlStr = [NSString stringWithFormat:@"mailto:742213138@qq.com?subject=iOS客户端Crash报告&body=针对本次应用出现的故障，表示非常抱歉！感谢您的配合，发送这封邮件给我们的开发者，协助我们改善此应用，提高您的体验！<br>"
                        "错误详情:<br>iOS_Version:%@<br>--------------------------<br>app_Version:%@<br>--------------------------<br>iPhoneType:%@<br>--------------------------<br>dateStr:%@<br>--------------------------<br>name:%@<br>--------------------------<br>reason:%@<br>---------------------<br>message:%@<br>---------------------<br>%@",
                        iOS_Version,
                        app_Version,
                        iPhoneType,
                        dateStr,
                        name,
                        reason,
                        exceptionString,
                        [arr componentsJoinedByString:@"<br>"]];
    
    NSURL *mailUrl = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:mailUrl];
}

@implementation MyUncaughtExceptionHandler

- (NSString *)applicationDocumentsDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void)setDefaultHandler{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler *)getHandler{
    return NSGetUncaughtExceptionHandler();
}

+ (void)TakeException:(NSException *)exception{
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason];
    NSString * name = [exception name];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    //    NSLog(@"%s:%d %@", __FUNCTION__, __LINE__, url);
    NSString *exceptionString = [NSString stringWithFormat:@"[文件名:%s] [函数名:%s] [行号:%d] [异常:%@]",__FILE__,__FUNCTION__,__LINE__,exception];
    NSLog(@"%@",exceptionString);
}

@end
