//
//  AppDelegate.m
//  CrashProject
//
//  Created by Hosel on 2017/8/3.
//  Copyright © 2017年 Hosel. All rights reserved.
//

#import "AppDelegate.h"
#import "MyUncaughtExceptionHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MyUncaughtExceptionHandler setDefaultHandler];
    return YES;
    
    //    NSSetUncaughtExceptionHandler(& caughtException);
    
//    @try {
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"明",@"name",nil];
//        NSMutableArray *array = [NSMutableArray array];
//        [array addObject:dic];
//        NSDictionary *dic1 = array[1];
//    }
//    @catch (NSException *exception)
//    {
//        NSString *exceptionString = [NSString stringWithFormat:@"[文件名:%s] [函数名:%s] [行号:%d] [异常:%@]",__FILE__,__FUNCTION__,__LINE__,exception];
//        NSLog(@"%@",exceptionString);
//        //[CommFun showException:exceptionString];
//        
//    }
//    @finally {
//        return YES;
//    }
}

void caughtException(NSException *exception)
{
    if (exception == nil) return;
    NSLog(@"CRASH:%@",exception);
    NSLog(@"Stack Trace:%@", exception.callStackSymbols);
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告======== name:%@ reason: %@ callStackSymbols: %@",name,reason,[callStack componentsJoinedByString:@" "]];
    
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:439581805@qq.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
    // 打开地址
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
