//
//  UIColor+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKitDefines.h>


/**
 渐变方式

 - SSColorGradientDirectionLevel: 渐变方式
 */
typedef NS_ENUM(NSInteger, SSColorGradientDirection) {
    SSColorGradientDirectionLevel,              //水平渐变
    SSColorGradientDirectionVertical,           //竖直渐变
    SSColorGradientDirectionUpwardDiagonalLine, //向下对角线渐变
    SSColorGradientDirectionDownDiagonalLine,   //向上对角线渐变
};

@interface UIColor (SSCategory)

/**
 *  32位RGB值
 *
 */
+ (UIColor *)colorWithRGBValue:(uint32_t)rgb;
+ (UIColor *)colorWithRGBAValue:(uint32_t)rgba;

- (uint32_t)RGBValue;
- (uint32_t)RGBAValue;
- (NSString *)stringValue;
- (CGFloat)alpha;
- (CGFloat)red;
- (CGFloat)green;
- (CGFloat)blue;

/**
 *  十六制颜色值
 *
 *  @param string #XXXX
 *
 *  @return 返回一个新的颜色对象
 */
+ (UIColor *)colorWithString:(NSString *)string;


/**
 颜色渐变

 @param size 尺寸
 @param direction 渐变方向
 @param startcolor 起始颜色
 @param endColor 结束颜色
 */
+ (instancetype)colorGradientFrameSize:(CGSize)size
                             direction:(SSColorGradientDirection)direction
                            startColor:(UIColor *)startcolor
                              endColor:(UIColor *)endColor;


@end
