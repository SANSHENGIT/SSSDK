//
//  UIImage+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+SSCategory.h"


@interface UIImage (SSCategory)

+ (UIImage*)createImageWithColor:(UIColor*)color;

/*! 自定义Size 和 颜色 来创建UIImage */
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (instancetype)setImageSize:(CGSize)size;

+ (UIImage *)imageWithName:(NSString *)name;



/**
 *  以一个UIColor对象创建一个UIImage对象
 *
 *  @param color UIColor obj
 *  @param size  UIImage size
 *
 *  @return UIImage obj
 */
+ (instancetype)imageColor:(UIColor *)color size:(CGSize)size;

/**
 *  使用UIColor对象创建UIImage(固定100px * 100px)
 *
 *  @param color 一个UIColor对象
 *
 *  @return 返回一张新图片
 */
+ (instancetype)imageColor:(UIColor *)color;

/**
 *  使用16进制颜色值创建UIImage
 *
 *  @param hexColor 16进制颜色值
 *  @param size     CGSize size
 *
 *  @return UIImage obj
 */
+ (instancetype)imageHexColor:(NSString *)hexColor size:(CGSize)size;

/**
 *  使用16进制颜色值创建UIImage(固定100px * 100px)
 *
 *  @param hexColor 16进制颜色值
 *
 *  @return UIImage obj
 */
+ (instancetype)imageHexColor:(NSString *)hexColor;

/**
 *  马赛格Image
 *
 *  @param image 需要处理的image
 *  @param blur  伐值 (0<-->1)
 *
 *  @return 返回一张马赛格图
 */
+ (instancetype)blurryImage:(UIImage *)image blur:(CGFloat)blur;

/**
 *  初始化一个圆角矩形的XMCUIImage
 *
 *  @param size            大小
 *  @param borderColor     边框颜色
 *  @param backgroundColor 背景色
 *  @param radius          半径
 *
 *  @return 返回一个XMCUIImage 对象
 */
+ (instancetype)imageSize:(CGSize)size borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor radius:(CGFloat)radius;

+ (instancetype)circleImageName:(NSString*)imageName round:(CGFloat)round;

/**
 *  直接获取本地图片文件(此图片不会缓存到内存)
 *
 *  @param imageName 图片名
 *
 *  @return image
 */
+ (instancetype)imageWithPNGFileName:(NSString*)imageName;
+ (instancetype)imageWithMPEGFileName:(NSString*)imageName;


/**
 *  返回一张能自由拉伸的图片
 *
 *  @param name      图片名
    size [size.width 左边有多少比例不需要拉伸(0~1)] [@param size.height  顶部有多少比例不需要拉伸(0~1)]
 */
+ (instancetype)resizableImage:(NSString *)name size:(CGSize)size;


@end
