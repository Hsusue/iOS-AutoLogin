//
//  HSUUserDefault.m
//  LoginTest
//
//  Created by Hsusue on 2018/7/22.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "HSUUserDefault.h"

@implementation HSUUserDefault

+(void)saveUserDefaultObject:(id)object key:(NSString *)key
{
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}


+(id)getUserDefaultObject:(NSString *)key
{
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    id tempObject = [defaults objectForKey:key];
    return tempObject;
}


+(void)removeObjectWithKey:(NSString *)key
{
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

@end
