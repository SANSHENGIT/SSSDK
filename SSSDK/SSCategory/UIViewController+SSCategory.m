//
//  UIViewController+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "UIViewController+SSCategory.h"

@implementation UIViewController (SSCategory)

- (void)setNavigationLeftBarButtonItemWithImage:(NSString *)imageName
{
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem itemWithImageName:imageName highImageName:nil target:self action:@selector(popViewController)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
