//
//  YXYTextField.m
//  Login
//
//  Created by Hsusue on 2018/5/1.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "HSUTextField.h"

@implementation HSUTextField

//// 设置左视图与输入框左侧的距离
//- (CGRect)leftViewRectForBounds:(CGRect)bounds {
//    CGRect iconRect = [super leftViewRectForBounds:bounds];
//    iconRect.origin.x += 15; //像右边偏15
//    return iconRect;
//}
//
////UITextField 文字与输入框的距离
//- (CGRect)textRectForBounds:(CGRect)bounds{
//
//    return CGRectInset(bounds, 45, 0);
//
//}
//
////控制文本的位置
//- (CGRect)editingRectForBounds:(CGRect)bounds{
//
//    return CGRectInset(bounds, 45, 0);
//}

- (void)configPlaceholder:(NSString *)placeholder
            leftImageName:(NSString *)imageName {
    NSInteger heigh = self.frame.size.height;
    UIImageView *leftPaddingView = [[UIImageView alloc] initWithFrame:CGRectMake(15, heigh/6, heigh/6*3, heigh/6*4)];
    leftPaddingView.image = [UIImage imageNamed:imageName];
    
    
    
    // 对于左视图，只有宽度起到了作用
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, heigh)];
    [leftView addSubview:leftPaddingView];
    [leftPaddingView setCenter:CGPointMake(leftPaddingView.center.x, leftView.center.y)];
    leftPaddingView.backgroundColor = [UIColor clearColor];
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.placeholder = placeholder;
}


- (void)configSecureButtonWithNormalImageName:(NSString *)normalImageName
                          selectedImageName:(NSString *)selectedImageName {
    CGFloat height = self.frame.size.height;
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, height/6, height/6*4 * 1.1, height/6*4 /16*11)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    // 对于右视图，只有宽度起到了作用
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, height)];
    [rightView addSubview:rightBtn];
    [rightBtn setCenter:CGPointMake(rightBtn.center.x, rightView.center.y)];
    rightBtn.backgroundColor = [UIColor clearColor];
    
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
    self.secureTextEntry = YES;
}

// 密码文置反
- (void)btnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.secureTextEntry = !self.secureTextEntry;
    
    if ([self isFirstResponder]) {
        [self becomeFirstResponder];
    }
    
    if ([self.btnDelegate respondsToSelector:@selector(changeAfterClickSecureButton:)]) {
        [self.btnDelegate changeAfterClickSecureButton:btn];
    }
}

@end
