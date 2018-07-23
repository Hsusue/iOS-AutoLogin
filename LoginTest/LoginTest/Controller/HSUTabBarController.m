//
//  YXYTabBarController.m
//  NewYouXiaoYun
//
//  Created by Hsusue on 2018/4/3.
//  Copyright © 2018年 topView. All rights reserved.
//

#import "HSUTabBarController.h"
#import "FirstVC.h"
#import "SecondVC.h"

@interface HSUTabBarController ()

@end

@implementation HSUTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建子控制器
    FirstVC *firstVC = [[FirstVC alloc] init];
    [self setTabBarItem:firstVC.tabBarItem
                  title:@"首页"
              titleSize:9.0
          titleFontName:@"PingFang-SC-Medium"
          selectedImage:@"首页"
     selectedTitleColor:[UIColor blackColor]
            normalImage:@"首页"
       normalTitleColor:[UIColor grayColor]];
    
    
    SecondVC *secondVC = [[SecondVC alloc] init];
    [self setTabBarItem:secondVC.tabBarItem
                  title:@"设置"
              titleSize:9.0
          titleFontName:@"PingFang-SC-Medium"
          selectedImage:@"设置"
     selectedTitleColor:[UIColor blackColor]
            normalImage:@"设置"
       normalTitleColor:[UIColor grayColor]];
    
    UINavigationController *firstNV = [[UINavigationController alloc] initWithRootViewController:firstVC];
    UINavigationController *secondNV = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    //设置导航栏的背景颜色和标题中的字体的大小和字体的颜色
//    firstNV.navigationBar.barTintColor = kNavigationBarColor;
    [firstNV.navigationBar setTitleTextAttributes:@{
                                                     NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f],
                                                     NSForegroundColorAttributeName:[UIColor whiteColor]
                                                     }];
//    secondNV.navigationBar.barTintColor=kNavigationBarColor;
    [secondNV.navigationBar setTitleTextAttributes:@{
                                                     NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f],
                                                     NSForegroundColorAttributeName:[UIColor whiteColor]
                                                     }];
   
    // 把子控制器添加到UITabBarController
    self.viewControllers = @[firstNV, secondNV];
}


/**
 设置tabBar的属性

 */
- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
            titleSize:(CGFloat)size
        titleFontName:(NSString *)fontName
        selectedImage:(NSString *)selectedImage
   selectedTitleColor:(UIColor *)selectColor
          normalImage:(NSString *)unselectedImage
     normalTitleColor:(UIColor *)unselectColor
{

    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAutomatic] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    UIImageRenderingMode
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateNormal];
    
    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateSelected];
}

@end
