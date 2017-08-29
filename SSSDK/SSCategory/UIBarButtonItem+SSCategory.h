//
//  UIBarButtonItem+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+SSCategory.h"
#import "CALayer+SSCategory.h"
#import "UIView+SSCategory.h"

@interface UIBarButtonItem (SSCategory)
/**
 *  通过传入图片名设置按钮来自定义UIBarButtonItem
 *
 *  @param imageName     普通状态图片名
 *  @param highImageName 高亮状态图片名
 *  @param target        接受点击事件的目标
 *  @param action        点击事件
 *
 *  @return 自定义的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

/**
 <#Description#>
 
 @param title <#title description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
