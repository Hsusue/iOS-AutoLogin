//
//  HSUCookieTool.m
//  cookieTest
//
//  Created by Hsusue on 2018/7/25.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "HSUCookieTool.h"

@implementation HSUCookieTool

+ (void)saveCookieWithName:(NSString *)name value:(NSString *)value domain:(NSString *)domain{
    // 保存
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    // 给cookie取名
    [cookieProperties setObject:name  forKey:NSHTTPCookieName];
    // 设置cookie的值
    [cookieProperties setObject:value forKey:NSHTTPCookieValue];
    // 存放目录
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    // 设置域名
    [cookieProperties setObject:[NSURL URLWithString:domain].host forKey:NSHTTPCookieDomain];
//    // 设置过期时间 一年后
    [cookieProperties setValue:[NSDate dateWithTimeIntervalSinceNow:3600*24*30*12] forKey:NSHTTPCookieExpires];
    // 生成cookie
    NSHTTPCookie *httpCookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    // 存入仓库
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:httpCookie];
}

+ (void)deleteCookieWithName:(NSString *)name {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"cookie%@", cookie);
        if ([cookie.name isEqualToString:name]) {
            [cookieJar deleteCookie:cookie];
        }
    }
}

+ (NSHTTPCookie *)cookieWithName:(NSString *)name {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"cookie%@", cookie);
        if ([cookie.name isEqualToString:name]) {
            return cookie;
        }
    }
    return nil;
}


@end
