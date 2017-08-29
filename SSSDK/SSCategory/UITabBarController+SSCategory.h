//
//  UITabBarController+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+SSCategory.h"
#import "SSCommonlyMacro.h"

@interface UITabBarController (SSCategory)

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
                 isCap:(BOOL)isCap;


@end
