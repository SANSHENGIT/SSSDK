//
//  UILabel+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+SSCategory.h"
#import "UIView+SSCategory.h"

@interface UILabel (SSCategory)

- (void)setCornerRaidus:(CGFloat)raidus;
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

/**
 根据文本内容自动计算frame
 固定宽度
 */
- (void)fixedWidthComputeWidthText:(NSString *)text;


/**
 根据文本内容自动计算frame
 固定高度
 */
- (void)fixedHeightComputeWithText:(NSString *)text;

@end
