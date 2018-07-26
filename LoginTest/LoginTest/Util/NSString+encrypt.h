//
//  NSString+encrypt.h
//  LoginTest
//
//  Created by Hsusue on 2018/7/26.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encrypt)


/**
 给定一个字符串，对该字符串进行Base64编码，然后返回编码后的结果


 @return 加密字符串
 */
- (NSString *)base64Encode;



/**
 对base64编码后的字符串进行解码

 @return 原字符串
 */
- (NSString *)base64Decode;

@end
