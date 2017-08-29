//
//  UIView+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CALayer+SSCategory.h"
#import "CAAnimation+SSCategory.h"

typedef NS_ENUM(NSUInteger, CCUIViewBadgeStyle) {
    CCUIViewBadgeStyleRedDot = 0,
    CCUIViewBadgeStyleNumber = 1 << 0,
    CCUIViewBadgeStyleNew    = 1 << 1,
};

typedef NS_ENUM(NSUInteger, CCUIViewBadgeAnimType) {
    CCUIViewBadgeAnimTypeNone    = 0,       /** 无标记动画 */
    CCUIViewBadgeAnimTypeScale   = 1 << 0,  /** 标记动画比例扩大 */
    CCUIViewBadgeAnimTypeShake   = 1 << 1,  /** 无标记动画摇摆 */
    CCUIViewBadgeAnimTypeBreathe = 1 << 2   /** 无标记动画心跳 */
};

typedef NS_ENUM(NSInteger, CCUIViewBorderOptions) {
    CCUIViewBorderOptionNone   = 0,
    CCUIViewBorderOptionTop    = 1 << 0,/** 边框添加在顶部 */
    CCUIViewBorderOptionRight  = 1 << 1,/** 边框添加在右边 */
    CCUIViewBorderOptionBottom = 1 << 2,/** 边框添加在底部 */
    CCUIViewBorderOptionLeft   = 1 << 3 /** 边框添加在左边 */
};

#define kPx(s) (s*0.5)

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);


@interface UIView (SSCategory)

@property (nonatomic) CGFloat x; /* self.origin.x */
@property (nonatomic) CGFloat y; /* self.origin.y */

@property (nonatomic) CGFloat maxX; /* CGRectGetMaxX(self.frame) */
@property (nonatomic) CGFloat minX; /* CGRectGetMinX(self.frame) */
@property (nonatomic) CGFloat maxY; /* CGRectGetMaxY(self.frame) */
@property (nonatomic) CGFloat minY; /* CGRectGetMinY(self.frame) */

@property (nonatomic) CGFloat width;    /* self.frame.size.width */
@property (nonatomic) CGFloat height;   /* self.frame.size.height */

@property (nonatomic) CGSize  size;     /* self.frame.size */
@property (nonatomic) CGPoint origin;   /* self.frame.origin */

@property (nonatomic, assign) CGFloat top;      /* self.origin.y */
@property (nonatomic, assign) CGFloat bottom;   /* self.top + self.height */
@property (nonatomic, assign) CGFloat left;     /* self.origin.x */
@property (nonatomic, assign) CGFloat right;    /* self.left + self.width */

@property (nonatomic, assign) CGFloat centerX; /* self.center.x */
@property (nonatomic, assign) CGFloat centerY; /* self.center.y */

@property (nonatomic, assign, readonly) CGFloat orientationIsPortraitWidth;/** 返回竖屏\横屏时的宽度. */
@property (nonatomic, assign, readonly) CGFloat orientationIsPortraitHeight;/** 返回竖屏\横屏时的宽度. */
#pragma mark - init
- (instancetype)createLayerView:(CGRect)frame;


#pragma mark -

/**
 裁剪一个空心圆
 
 @param radius 这个空心的半径
 */
- (CAShapeLayer *)removeClipWithRadius:(CGFloat)radius;

/**
 画一个空心圆圈
 
 @param radius 圆的半径
 @param lineWidth 线圈轨迹的宽
 */
- (void)setClipLinkWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth;
- (void)setClipLinkWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color;


/**
 这是一个很多层的圆
 
 @param radius <#radius description#>
 @param lineWidth <#lineWidth description#>
 @param color <#color description#>
 */
- (void)setClipWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color;

/**
 苹果自带的高斯模糊效果
 
 @param blurEffectStyle 黑:UIBlurEffectStyleDark 白:UIBlurEffectStyleLight
 */
- (void)addCoreBlurEffect:(UIBlurEffectStyle)blurEffectStyle;
- (void)addCoreBlurEffect:(UIBlurEffectStyle)blurEffectStyle frame:(CGRect)frame;


/**
 无限旋转动画
 
 @param duration 完整一圈所需时间
 */
- (void)addRotationWithDuration:(CGFloat)duration;


/**
 渐变图层
 默认上/下透明,中间可见
 */
- (void)setGradientLayerView;
/*
 使用方法: [UIView addGradientLayerWithView:self.tableView];
 @return 返回一个新的UIView,此View的子视图为gradientView
 */
+ (UIView *)addGradientLayerWithView:(UIView *)gradientView;


#pragma mark -


/**
 *  添加一组子视图
 *
 *  @param views 子视图数组
 */
- (void)addSubviews:(NSArray *)views;
/**
 *  移除指定一组子视图
 *
 *  @param views 需要移除的子视图数组
 */
- (void)removeSubviews:(NSArray *)views;
/**
 *  移除所有子视图
 */
- (void)removeAllSubviews;

#pragma mark - cuttTool(切圆/切割)
@property (nonatomic, assign, readonly) CGFloat cornerRadius; /** 获取弧度 */
- (void)setCornerRadius:(CGFloat)cornerRadius;/** 设置圆角 */
/*!
 *  添加边框
 *
 *  @param borderDirect 方向
 *  @param color        框架颜色
 *  @param width        边框宽度
 *
 */
- (void)setBorderDirect:(CCUIViewBorderOptions)borderDirect
                     color:(UIColor *)color
                     width:(CGFloat)width;


/*!
 *  添加阴影 (注意,切勿添加clipsToBounds,否则阴影无效)
 *
 *  @param color  阴影颜色
 *  @param size   阴影偏移量
 *  @param radius 阴影厚度 (默认值为3)
 *  @param alpha  阴影透明度0->1
 *
 */
- (void)setShadowColor:(UIColor *)color
             shadowOffset:(CGSize )size
             shadowRadius:(CGFloat)radius
                    alpha:(CGFloat)alpha;

#pragma mark - ----------- Badge -----------

- (void)shakeView;

@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, assign) CCUIViewBadgeAnimType aniType;

- (void)showUIBadge;
- (void)showBadgeWithStyle:(CCUIViewBadgeStyle)style value:(NSInteger)value animationType:(CCUIViewBadgeAnimType)aniType;
- (void)clearBadge;

#pragma mark - ----------- animate -----------
/** 移动到指定位置 */
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
/** 移动到指定位置 代理 移动完成后执行SEL */
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

/**
 *  旋转动画
 *
 *  @param degrees  旋转角度
 *  @param duration 旋转一周时间
 *  @param delegate 代理者
 *  @param method   旋转动画完成后,代理需要执行的SEL
 */
- (void)rotate:(int)degrees duration:(NSTimeInterval)duration delegate:(id)delegate callback:(SEL)method;
/**
 *  按指定比例扩大或缩小
 *
 *  @param duration 执行时间
 *  @param scaleX   扩大 x轴
 *  @param scaleY   扩大 y轴
 *  @param delegate 代理
 *  @param method   动画完成后,代理需要执行的SEL
 */
- (void)scaleDuration:(NSTimeInterval)duration x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;

/**
 *  顺时针方向旋转 (无循环)
 *
 *  @param secs 旋转一周时间
 */
- (void)spinClockwise:(NSTimeInterval)secs;
/**
 *  逆时针旋转 (无循环)
 *
 *  @param secs 旋转一周时间
 */
- (void)spinCounterClockwise:(NSTimeInterval)secs;


- (void)AnimationCurlDownFromDuration:(NSTimeInterval)duration;
- (void)AnimationCurlUpFromDuration:(NSTimeInterval)duration;

/** 指定谈入/谈出时间 并设置谈入谈出最终透明值 */
- (void)AlphaFormDuration:(NSTimeInterval)duration alpha:(CGFloat)alpha;
/** 谈出0.3 -> 谈入1.0 */
- (void)SparklDuration:(float)duration isLoop:(BOOL)isLoop;


#pragma mark - ----------- add subview -----------
/** 添加子视图 有动画的 */
- (void)addSubview:(UIView *)view alphaAnimationDuration:(NSTimeInterval)duration;

#pragma mark - ----------- UITapGestureRecognizer -----------
/**
 *  为UIView添加点击手势
 *
 *  @param isOpen 是否开启
 *  @param action 点击响应回调
 */
- (void)addTargetForOpenRecognizer:(BOOL)isOpen ActionrRespond:(GestureActionBlock)action;
/**
 *  为UIView添加长按手势
 *
 *  @param isOpen 是否开启
 *  @param action 手势响应回调
 */
- (void)addTongForOpenRecognizer:(BOOL)isOpen ActionrRespond:(GestureActionBlock)action;

/**
 *  返回第一响应者的ViewController
 */
- (UIViewController *)firstResponderViewController;


@end


@interface UIView (SSCategory_UINib)

+ (instancetype)nibWithFrame:(CGRect)frame;

@end


@interface UIView (EffectView)

/** 设置Effect效果 */
- (void)setEffectWithStyle:(UIBlurEffectStyle)effectStyle;
- (void)setEffectWithStyle:(UIBlurEffectStyle)effectStyle backgroundImage:(UIImage *)backgroundImage;

@end
