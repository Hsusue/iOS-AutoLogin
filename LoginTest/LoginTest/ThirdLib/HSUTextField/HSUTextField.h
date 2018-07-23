//
//  YXYTextField.h
//  Login
//
//  Created by Hsusue on 2018/5/1.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HSUTextFieldDelegate <NSObject>
@optional
- (void) changeAfterClickSecureButton:(UIButton *)btn;
@end



@interface HSUTextField : UITextField

@property (nonatomic, weak) id <HSUTextFieldDelegate> btnDelegate;

- (void)configPlaceholder:(NSString *)placeholder
            leftImageName:(NSString *)imageName;



/**
 设置明暗文显示按钮

 @param normalImageName 暗文状态下按钮图片
 @param selectedImageName 明文状态下按钮图片
 */
- (void)configSecureButtonWithNormalImageName:(NSString *)normalImageName
                          selectedImageName:(NSString *)selectedImageName;

///**
// 显示右边按钮控制密码明暗文
// */
//@property (nonatomic, assign, getter=isShowSecureButton) BOOL showSecureButton;// 默认NO

@end
