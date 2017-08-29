//
//  SSAdScrollView.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+SSCategory.h"
#import "SSCommonlyMacro.h"

#define SSAdPageControlHeight 30
#define SSAdImageViewTagBase  100

#define SSAdDefaultDelay 3
#define SSAdAutoScrollDuration 0.5

/**
 动画类型
 
 - MXImageAnimationNone: 默认无动画
 - MXImageAnimationFadeInOut: 渐变
 - MXImageAnimationRotation: 旋转
 - MXImageAnimationScale: 缩放
 - MXImageAnimationDown: 下降
 - MXImageAnimationUp: 上升
 - MXImageAnimationBlur: 毛玻璃
 */
typedef NS_ENUM(NSInteger, SSAdImageAnimation) {
    SSAdImageAnimationNone,
    SSAdImageAnimationFadeInOut,
    SSAdImageAnimationRotation,
    SSAdImageAnimationScale,
    SSAdImageAnimationUp,
    SSAdImageAnimationDown,
    SSAdImageAnimationBlur
};

typedef void(^SSAdClickImageHandler)(NSInteger index);

@protocol SSAdScrollViewDelegate <NSObject>

@optional
- (void)clickImageIndex:(NSInteger)index;

@end
@interface SSAdScrollView : UIScrollView

//图片内容
@property (strong, nonatomic) NSArray <NSString*>* contents;
//自动滚动间隔时间
@property (assign, nonatomic) CGFloat delay;
@property (weak, nonatomic)   id <SSAdScrollViewDelegate> delegate;
@property (strong, nonatomic) UIImage *placeholderImage;
@property (copy, nonatomic)   SSAdClickImageHandler clickHandler;
//是否显示pageControl，默认显示
@property (assign, nonatomic) BOOL hidePageControl;
//pageControl颜色
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
//动画类型，默认无动画
@property (assign, nonatomic) SSAdImageAnimation animationType;
//缩放动画的缩放系数（0~0.9）
@property (assign, nonatomic) CGFloat scaleRatio;

/**
 初始化（用于事先不知道图片数据，一般图片数据有网络请求而来，先设置好视图，然后设置contents属性）
 
 @param frame 位置
 @param delay 自动滚动间隔时间
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withScrollDelay:(CGFloat)delay;

/**
 初始化（用于事先知道图片数据）
 
 @param frame 位置
 @param contents 图片地址
 @param delay 自动滚动间隔时间
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withContents:(NSArray<NSString*>*)contents andScrollDelay:(CGFloat)delay;



@end
