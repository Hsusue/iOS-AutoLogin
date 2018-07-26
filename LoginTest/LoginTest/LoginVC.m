//
//  LoginVC.m
//  LoginTest
//
//  Created by Hsusue on 2018/7/21.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#import "LoginVC.h"
#import <Masonry.h>
#import "HsuLoginAnimView.h"
#import "HSUTextField.h"
#import "HSUTabBarController.h"
#import "AppDelegate.h"
#import "NSString+encrypt.h"

@interface LoginVC ()<UITextFieldDelegate, HSUTextFieldDelegate>

@property (nonatomic, strong) HsuLoginAnimView *animView;
@property (nonatomic, strong) HSUTextField *userNameTextField;
@property (nonatomic, strong) HSUTextField *psdTextField;
@property (nonatomic, strong) UISwitch *rememberSwitch;
@property (nonatomic, strong) UISwitch *autoLoginSwitch;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
    [self configData];
    
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.frame.origin.y == self.userNameTextField.frame.origin.y){//账号文本框
        //睁开眼睛
        [self.animView startAnim:NO];
        
    }else {//密码文本框
        if (textField.secureTextEntry == YES) {
            //闭上眼睛
            [self.animView startAnim:YES];
        } else {
            [self.animView startAnim:NO];
        }
    }
}

#pragma mark - HSUTextFieldDelegate
- (void)changeAfterClickSecureButton:(UIButton *)btn {
    if (btn.selected) { // 明文
        [self.animView startAnim:NO];
    } else { // 暗文
        [self.animView startAnim:YES];
    }
}


#pragma mark - event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.psdTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];
}

- (void)switchAction:(UISwitch *)sender {
    if (sender.tag == 1000) { // 记住密码
        if (sender.on == NO) {
            [self.autoLoginSwitch setOn:NO animated:YES];
        }
    }
    if (sender.tag == 1001) { // 自动登录
        if (sender.on == YES) {
            [self.rememberSwitch setOn:YES animated:YES];
        }
    }
}

- (void)loginBtnClick {
    // 本Demo 不进行账号密码检验
    // 默认登录成功
    [self loginSuccess];
    
    // 登录失败不属于自动登录研究范围
}

- (void)loginSuccess {
    [HSUUserDefault saveUserDefaultObject:self.userNameTextField.text key:kUserName];
    BOOL isAutoLogin = self.autoLoginSwitch.on;
    if (isAutoLogin) {
        [HSUUserDefault saveUserDefaultObject:@(YES) key:kAutoLogin];
        [HSUUserDefault saveUserDefaultObject:@(YES) key:kRememberPassword];
        [HSUUserDefault saveUserDefaultObject:[self.psdTextField.text base64Encode] key:kUserPassword];
    } else { // 不自动登录
        [HSUUserDefault saveUserDefaultObject:@(NO) key:kAutoLogin];
        
        BOOL isRememberPsd = self.rememberSwitch.on;
        if (isRememberPsd) { // 记住密码
            [HSUUserDefault saveUserDefaultObject:@(YES) key:kRememberPassword];
            [HSUUserDefault saveUserDefaultObject:[self.psdTextField.text base64Encode] key:kUserPassword];
        } else {
            [HSUUserDefault saveUserDefaultObject:@(NO) key:kRememberPassword];
            [HSUUserDefault saveUserDefaultObject:nil key:kUserPassword];
        }
    }
    
    // 切换AppDelegate的控制器
    HSUTabBarController *tabBarController = [[HSUTabBarController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.tabBarCtl = tabBarController;
    appDelegate.window.rootViewController = appDelegate.tabBarCtl;
}

#pragma mark - 布置界面及数据
- (void)setupView {
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@300);
        make.height.equalTo(@100);
        make.top.equalTo(self.view).offset(150);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    self.animView = [HsuLoginAnimView loginAnimView];
    [contentView addSubview:self.animView];
    contentView.clipsToBounds = YES;
    
    self.userNameTextField = [[HSUTextField alloc] init];
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(0);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@32);
    }];
    self.psdTextField = [[HSUTextField alloc] init];
    [self.view addSubview:self.psdTextField];
    [self.psdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTextField.mas_bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@32);
    }];
    [self.view layoutIfNeeded];// textField配置要用到frame
    
    self.userNameTextField.delegate = self;
    self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.userNameTextField setFont:[UIFont systemFontOfSize:16.0f]];
    self.userNameTextField.textColor = RGB(102, 102, 102);
    self.userNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.userNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.userNameTextField configPlaceholder:@"请输入账号" leftImageName:@"账号"];
    
    self.psdTextField.delegate = self;
    self.psdTextField.btnDelegate = self;
    self.psdTextField.secureTextEntry = YES;
    [self.psdTextField setFont:[UIFont systemFontOfSize:16.0f]];
    self.psdTextField.textColor = RGB(102, 102, 102);
    self.psdTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.psdTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.psdTextField configPlaceholder:@"请输入密码" leftImageName:@"密码"];
//    self.psdTextField.showSecureButton = YES;
    [self.psdTextField configSecureButtonWithNormalImageName:@"闭眼" selectedImageName:@"睁眼"];
    
    UILabel *rememberLabel = [[UILabel alloc] init];
    rememberLabel.text = @"记住密码";
    [self.view addSubview:rememberLabel];
    [rememberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.width.equalTo(@70);
        make.height.equalTo(@50);
        make.top.equalTo(self.psdTextField.mas_bottom).offset(10);
    }];
    self.rememberSwitch = [[UISwitch alloc] init];
    self.rememberSwitch.tag = 1000;
    [self.rememberSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.rememberSwitch];
    [self.rememberSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rememberLabel.mas_centerY);
        make.left.equalTo(rememberLabel.mas_right).offset(10);
    }];
    
    UILabel *autoLoginLabel = [[UILabel alloc] init];
    autoLoginLabel.text = @"自动登录";
    [self.view addSubview:autoLoginLabel];
    [autoLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-100);
        make.width.equalTo(@70);
        make.height.equalTo(@50);
        make.top.equalTo(self.psdTextField.mas_bottom).offset(10);
    }];
    self.autoLoginSwitch = [[UISwitch alloc] init];
    self.autoLoginSwitch.tag = 1001;
    [self.autoLoginSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.autoLoginSwitch];
    [self.autoLoginSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(autoLoginLabel.mas_centerY);
        make.left.equalTo(autoLoginLabel.mas_right).offset(10);
    }];
    
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 10;
    loginBtn.backgroundColor = [UIColor blueColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(@50);
        make.top.equalTo(rememberLabel.mas_bottom).offset(50);
    }];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchDown];
    
}


/**
 设置界面的数据
 */
- (void)configData {
    self.userNameTextField.text = [HSUUserDefault getUserDefaultObject:kUserName];
//    BOOL isAutoLogin = [[HSUUserDefault getUserDefaultObject:kAutoLogin] boolValue];
//    if (isAutoLogin) {
//
//    }
    BOOL isRemember = [[HSUUserDefault getUserDefaultObject:kRememberPassword] boolValue];
    self.rememberSwitch.on = isRemember;
    if (isRemember) {
        self.psdTextField.text = [[HSUUserDefault getUserDefaultObject:kUserPassword] base64Decode];
    }
    
}

@end
