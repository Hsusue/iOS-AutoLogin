//
//  SecondVC.m
//  LoginTest
//
//  Created by Hsusue on 2018/7/23.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "SecondVC.h"
#import <Masonry.h>
#import "AppDelegate.h"
#import "LoginVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {    
    UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOutBtn setTitle:@"注销账号" forState:UIControlStateNormal];
    [loginOutBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [loginOutBtn addTarget:self action:@selector(loginOutBtnClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:loginOutBtn];
    [loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
}

- (void)loginOutBtnClick {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否注销账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [HSUUserDefault saveUserDefaultObject:@(NO) key:kAutoLogin];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.tabBarCtl = nil;
        LoginVC *loginVC = [[LoginVC alloc] init];
        appDelegate.window.rootViewController = loginVC;
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
