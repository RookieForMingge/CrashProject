//
//  MyUncaughtExceptionHandler.h
//  CrashProject
//
//  Created by Hosel on 2017/8/3.
//  Copyright © 2017年 Hosel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MyUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler *)getHandler;
+ (void)TakeException:(NSException *)exception;

@end
