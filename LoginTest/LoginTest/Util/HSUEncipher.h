//
//  HSUEncipher.h
//  LoginTest
//
//  Created by Hsusue on 2018/7/25.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSUEncipher : NSObject

/**
 给定一个字符串，对该字符串进行Base64编码，然后返回编码后的结果

 @param string 原字符串
 @return 加密字符串
 */
+ (NSString *)base64EncodeString:(NSString *)string;



/**
 对base64编码后的字符串进行解码

 @param string 加密字符串
 @return 原字符串
 */
+ (NSString *)base64DecodeString:(NSString *)string;
@end
