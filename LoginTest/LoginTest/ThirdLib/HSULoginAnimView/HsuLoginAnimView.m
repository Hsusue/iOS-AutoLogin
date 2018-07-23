//
//  HsuLoginAnimView.m
//  通讯录
//
//  Created by Hsusue on 2017/12/10.
//  Copyright © 2017年 Hsusue. All rights reserved.
//

#import "HsuLoginAnimView.h"

@interface HsuLoginAnimView ()
@property (weak, nonatomic) IBOutlet UIImageView *leftArm;
@property (weak, nonatomic) IBOutlet UIImageView *rightArm;
@property (weak, nonatomic) IBOutlet UIImageView *leftHand;
@property (weak, nonatomic) IBOutlet UIImageView *rightHand;

@property (nonatomic, assign) CGFloat armOffsetY;
@property (nonatomic, assign) CGFloat leftArmOffsetX;
@property (nonatomic, assign) CGFloat rightArmOffsetX;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation HsuLoginAnimView
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 初始化手臂位置
    // y轴偏移量
    _armOffsetY = self.bounds.size.height - _leftArm.frame.origin.y;
    // 左边手臂x轴偏移量
    _leftArmOffsetX = -_leftArm.frame.origin.x;
    
    // 右边手臂x轴偏移量
    _rightArmOffsetX = _contentView.bounds.size.width - _rightHand.bounds.size.width - _rightArm.frame.origin.x;
    
    
    // 平移左边手臂
    _leftArm.transform = CGAffineTransformMakeTranslation(_leftArmOffsetX, _armOffsetY);
    
    // 平移右边手臂
    _rightArm.transform = CGAffineTransformMakeTranslation(_rightArmOffsetX, _armOffsetY);
    
    
}

+ (instancetype)loginAnimView
{
    return [[NSBundle mainBundle] loadNibNamed:@"HsuLoginAnimView" owner:nil options:nil][0];
}

- (void)startAnim:(BOOL)isClose
{
    __weak typeof(self) weakSelf = self;
    if(isClose){
        // 清空形变
        [UIView animateWithDuration:0.25 animations:^{
            // 手臂
            weakSelf.leftArm.transform = CGAffineTransformIdentity;
            weakSelf.rightArm.transform = CGAffineTransformIdentity;
            
            // 手
            weakSelf.leftHand.transform = CGAffineTransformMakeTranslation(-weakSelf.leftArmOffsetX, -weakSelf.armOffsetY + 5);
            weakSelf.leftHand.transform = CGAffineTransformScale(weakSelf.leftHand.transform, 0.01, 0.01);
            
            
            weakSelf.rightHand.transform = CGAffineTransformMakeTranslation(-weakSelf.rightArmOffsetX, -weakSelf.armOffsetY + 5);
            weakSelf.rightHand.transform = CGAffineTransformScale(weakSelf.rightHand.transform, 0.01, 0.01);
            
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            // 平移左边手臂
            weakSelf.leftArm.transform = CGAffineTransformMakeTranslation(weakSelf.leftArmOffsetX, weakSelf.armOffsetY);
            
            // 平移右边手臂
            weakSelf.rightArm.transform = CGAffineTransformMakeTranslation(weakSelf.rightArmOffsetX, weakSelf.armOffsetY);
            
            //手
            weakSelf.leftHand.transform = CGAffineTransformIdentity;
            weakSelf.rightHand.transform = CGAffineTransformIdentity;
        }];
    }
        
}


@end

