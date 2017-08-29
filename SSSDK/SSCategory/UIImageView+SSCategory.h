//
//  UIImageView+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SSCategory.h"
#import <UIImageView+WebCache.h>

@interface UIImageView (SSCategory)

+ (instancetype)imageViewWithFrame:(CGRect)frame;

+ (instancetype)imageView:(NSString *)imageName frame:(CGRect)frame;

/**
 创建圆形图片
 */
+ (instancetype)radiusImageViewWithFrame:(CGRect)frame;

/**
 设置图片边框
 */
- (void)setImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)brderColor;

/**
 加载本地资源图片 格式指定PNG
 */
- (instancetype)imageWithPNGName:(NSString *)imageName frame:(CGRect)frame;

/**
 加载本地资源图片 格式指定MPEG
 */
- (instancetype)imageWithMPEGName:(NSString *)imageName frame:(CGRect)frame;

/**
 从网络获图片
 */
- (void)ss_setImageWithURL:(NSString *)url;

/**
 从网络获图片

 @param url 网络图片
 @param image 默认图片
 */
- (void)setImageWithURL:(NSString *)url defineImageName:(NSString *)imageName;
- (void)setImageWithURL:(NSString *)url defineImage:(UIImage *)image;

/**
 从网络获图片

 @param url 网络图片
 @param image 默认图片
 @param options 策略类型
 */
- (void)setImageWithURL:(NSString *)url defineImage:(NSString *)image options:(SDWebImageOptions)options;

/**
 系统高斯模糊
 */
- (void)coreBlurWithBlurNumber:(CGFloat)blur;

@end
