//
//  HSUCookieTool.h
//  cookieTest
//
//  Created by Hsusue on 2018/7/25.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSUCookieTool : NSObject

/**
 生成cookie

 @param name cookie的名字
 @param value cookie的值
 @param domain 域名
 */
+ (void)saveCookieWithName:(NSString *)name value:(NSString *)value domain:(NSString *)domain;


/**
 删除cookie

 @param name cookie的名字
 */
+ (void)deleteCookieWithName:(NSString *)name;


/**
 通过名字获取cookie

 @param name cookie的名字
 @return 对应的cookie，可能为空
 */
+ (NSHTTPCookie *)cookieWithName:(NSString *)name;

@end
