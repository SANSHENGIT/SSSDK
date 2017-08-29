//
//  UITabBarController+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "UITabBarController+SSCategory.h"

@implementation UITabBarController (SSCategory)

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc
                 title:(NSString *)title
             imageName:(NSString *)imageName
     selectedImageName:(NSString *)selectedImageName
                 isCap:(BOOL)isCap
{
    // childVc.view.backgroundColor = [UIColor lightGrayColor];
    // 设置标题
    // 相当于同时设置了tabBarItem.title和navigationItem.title
    childVc.title = title;
    // childVc.tabBarItem.title = title; // tabbar标签上
    // childVc.navigationItem.title  = title; // 导航栏
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (ios6x) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    if (isCap) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];

        nav.title = title;
        [self addChildViewController:nav];
    } else {
        [self addChildViewController:childVc];
    }
    
    
}

@end
