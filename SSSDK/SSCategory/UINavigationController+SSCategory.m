//
//  UINavigationController+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "UINavigationController+SSCategory.h"

@interface UINavigationController () <UIGestureRecognizerDelegate>

@end
@implementation UINavigationController (SSCategory)

- (void)setPopGestureRecognizerDelegate
{
    self.interactivePopGestureRecognizer.delegate = self;
}

// 实现代理方法：返回 YES，则手势有效
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //当导航控制器的子控制器个数 大于1 手势才有效
    return self.childViewControllers.count > 1;
}

@end
