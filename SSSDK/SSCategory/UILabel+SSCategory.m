//
//  UILabel+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "UILabel+SSCategory.h"

@implementation UILabel (SSCategory)

- (void)setCornerRaidus:(CGFloat)raidus
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = raidus;
}
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}

/**
 根据文本内容自动计算frame
 固定宽度
 */
- (void)fixedWidthComputeWidthText:(NSString *)text {
    CGRect frame = self.frame;
    CGSize size = [text sizeWithFont:self.font forWidth:frame.size.width];
    
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height)];
    
}

/**
 根据文本内容自动计算frame
 固定高度
 */
- (void)fixedHeightComputeWithText:(NSString *)text
{
    CGRect frame = self.frame;
    CGSize size = [text sizeWithFont:self.font forHeight:frame.size.height];
    
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height)];
}


@end
