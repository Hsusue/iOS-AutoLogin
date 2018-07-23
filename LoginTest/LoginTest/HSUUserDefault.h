//
//  HSUUserDefault.h
//  LoginTest
//
//  Created by Hsusue on 2018/7/22.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSUUserDefault : NSObject

+(void)saveUserDefaultObject:(id)object key:(NSString *)key;

+(id)getUserDefaultObject:(NSString *)key;

+(void)removeObjectWithKey:(NSString *)key;

@end
