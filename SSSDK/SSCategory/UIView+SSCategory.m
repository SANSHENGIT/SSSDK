//
//  UIView+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "UIView+SSCategory.h"


static char badgeLabelKey;
static char badgeBgColorKey;
static char badgeTextColorKey;
static char badgeAniTypeKey;
static char badgeFrameJey;

#define kBadgeBreatheAniKey     @"breathe"
#define kBadgeRotateAniKey      @"rotate"
#define kBadgeShakeAniKey       @"shake"
#define kBadgeScaleAniKey       @"scale"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#define kAnimationDidStopNotification              @"kAnimationDidStopNotification"

#define kAnimationDidStartNotification              @"kAnimationDidStartNotification"

NSString *const kUIAnimationFlyOut = @"kUIAnimationFlyOut";
NSString *const kUIAnimationTypeOut = @"kUIAnimationTypeOut";
NSString *const kUIAnimationTargetViewKey = @"kUIAnimationTargetViewKey";
NSString *const kUIAnimationCallerDelegateKey = @"kUIAnimationCallerDelegateKey";
NSString *const kUIAnimationCallerStartSelectorKey = @"kUIAnimationCallerStartSelectorKey";
NSString *const kUIAnimationCallerStopSelectorKey = @"kUIAnimationCallerStopSelectorKey";
NSString *const kUIAnimationName = @"kUIAnimationName";
NSString *const kUIAnimationType = @"kUIAnimationType";

static char kActionHandlerTapBlockKey;//单击
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;//长按
static char kActionHandlerLongPressGestureKey;

// 非常有用的功能
float radiansForDegrees(int degrees) {
    return degrees * M_PI / 180;
}

@implementation UIView (SSCategory)

- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (void)setMaxX:(CGFloat)maxX{};

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}
- (void)setMaxY:(CGFloat)maxY {};

- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}
- (void)setMinX:(CGFloat)minX {};

- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}
- (void)setMinY:(CGFloat)minY {};

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGFloat)top {
    return self.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)left {
    return self.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right {
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)orientationIsPortraitWidth {
    return UIInterfaceOrientationIsLandscape(UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight) ? self.width : self.height;
}

- (CGFloat)orientationIsPortraitHeight {
    return UIInterfaceOrientationIsPortrait(UIInterfaceOrientationPortrait | UIInterfaceOrientationPortraitUpsideDown) ? self.height : self.width;
}

#pragma mark - init



- (instancetype)createLayerView:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    CAGradientLayer *layer = [CAGradientLayer createLayer];
    layer.frame = view.bounds;
    view.layer.mask = layer;
    
    return view;
}

#pragma mark - 
#pragma mark - 
- (CAShapeLayer *)removeClipWithRadius:(CGFloat)radius
{
    /**
     创建需要裁剪的贝塞尔路径
     
     centerX <#centerX description#>
     centerY <#centerY description#>
     radius  将要被裁剪的半径
     startAngle 裁剪的起始点
     endAngle   裁剪的结束点
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2, self.width/2) radius:radius startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    
    // MARK: roundRectanglePath  要保留的圆矩形路径
    // bezierPathByReversingPath:一个具有相同路径形状的新路径对象，但这个路径会在反方向上创建。
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.width, self.width) cornerRadius:self.width/2] bezierPathByReversingPath]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [self.layer setMask:shapeLayer];
    return shapeLayer;
}


- (void)setClipLinkWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth
{
    [self setClipLinkWithRadius:radius lineWidth:lineWidth color:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
}

- (void)setClipLinkWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color
{
    //创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2, self.width/2) radius:radius startAngle:0 endAngle:DEGREES_TO_RADIANS(360)   clockwise:YES];
    
    //添加背景圆环
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.lineWidth = lineWidth;
    backLayer.path = [path CGPath];
    backLayer.fillColor =  [[UIColor clearColor] CGColor];
    backLayer.strokeColor  = color.CGColor;
    [self.layer addSublayer:backLayer];
    
}


- (void)setClipWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color
{
    //创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2, self.width/2) radius:radius startAngle:0 endAngle:DEGREES_TO_RADIANS(360)   clockwise:YES];
    
    //添加背景圆环
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.lineWidth = lineWidth;
    backLayer.path = [path CGPath];
    backLayer.fillColor =  color.CGColor;
    backLayer.strokeColor  = color.CGColor;
    [self.layer addSublayer:backLayer];
}


- (void)addCoreBlurEffect:(UIBlurEffectStyle)blurEffectStyle
{
    [self addCoreBlurEffect:blurEffectStyle frame:self.bounds];
}

- (void)addCoreBlurEffect:(UIBlurEffectStyle)blurEffectStyle frame:(CGRect)frame
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:blurEffectStyle];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    [self addSubview:effectView];
}

- (void)addRotationWithDuration:(CGFloat)duration
{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat:M_PI *2];
    animation.duration  = duration;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [self.layer addAnimation:animation forKey:nil];
}

//[self.scrollView addSubview:[UIView addGradientLayerWithView:self.lyricsView]];
- (void)setGradientLayerView
{
    //  创建 CAGradientLayer 对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    //  设置 gradientLayer 的 Frame
    gradientLayer.frame = self.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,
                             (id)[UIColor yellowColor].CGColor,
                             (id)[UIColor clearColor].CGColor];
    //  设置三种颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@(0.1f),@(0.5f)];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0.15);//CGPointMake(0, 0.0)表示从最小Y值开始渐变
    gradientLayer.endPoint = CGPointMake(0, 0.85);//CGPointMake(0, 1.0)表示渐变到最大Y值
    [gradientLayer setFillMode:@"forwards"];
    
    [self.layer setMask:gradientLayer];
}

+ (UIView *)addGradientLayerWithView:(UIView *)gradientView
{
    UIView *aView = [[UIView alloc] initWithFrame:gradientView.frame];
    //  创建 CAGradientLayer 对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    //  设置 gradientLayer 的 Frame
    gradientLayer.frame = aView.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,
                             (id)[UIColor yellowColor].CGColor,
                             (id)[UIColor clearColor].CGColor];
    
    //  设置三种颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@(0.1f),@(0.5f)];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0.15);//CGPointMake(0, 0.0)表示从最小Y值开始渐变
    gradientLayer.endPoint = CGPointMake(0, 0.85);//CGPointMake(0, 1.0)表示渐变到最大Y值
    [gradientLayer setFillMode:@"forwards"];
    
    [aView.layer setMask:gradientLayer];
    gradientView.frame = aView.bounds;
    [aView addSubview:gradientView];
    return aView;
}

#pragma mark -
#pragma mark -

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)radius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderDirect:(CCUIViewBorderOptions)borderDirect
                     color:(UIColor *)color
                     width:(CGFloat)width {
    
    /*
     UIView *line = [[UIView alloc] init];
     line.backgroundColor = color;
     [self addSubview:line];
     //禁用autoresizing
     line.translatesAutoresizingMaskIntoConstraints = NO;
     
     NSDictionary *views = NSDictionaryOfVariableBindings(line);
     NSDictionary *metrics = @{@"w":@(width),@"y":@(self.Height - width),@"x":@(self.Width - width)};
     
     NSString *vfl_H;
     NSString *vfl_W;
     
     switch (borderDirect) {
     case UIViewBorderDirectTop:    vfl_H = @"H:|-0-[line]-0-|";  vfl_W = @"V:|-0-[line(==w)]";
     break;
     case UIViewBorderDirectBottom: vfl_H = @"H:|-0-[line]-0-|";  vfl_W = @"V:[line(==w)]-0-|";
     break;
     case UIViewBorderDirectLeft:   vfl_H = @"H:|-0-[line(==w)]"; vfl_W = @"V:|-0-[line]-0-|";
     break;
     case UIViewBorderDirectRight:  vfl_H = @"H:|-x-[line(==w)]"; vfl_W = @"V:|-0-[line]-0-|";
     break;
     default:
     break;
     }
     
     [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_H options:0 metrics:metrics views:views]];
     [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_W options:0 metrics:metrics views:views]];
     */
    CGFloat borderWidth = width;
    
    if ((borderDirect & CCUIViewBorderOptionTop)) {
        UIView* border = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), borderWidth)];
        border.backgroundColor = color;
        border.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:border];
    }
    
    if ((borderDirect & CCUIViewBorderOptionRight)) {
        UIView* border = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - borderWidth, 0, borderWidth, CGRectGetHeight(self.frame))];
        border.backgroundColor = color;
        border.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:border];
    }
    
    if ((borderDirect & CCUIViewBorderOptionBottom)) {
        UIView* border = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - borderWidth, CGRectGetWidth(self.frame), borderWidth)];
        border.backgroundColor = color;
        border.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:border];
    }
    
    if ((borderDirect & CCUIViewBorderOptionLeft)) {
        UIView* border = [[UIView alloc] initWithFrame:CGRectMake(0, 0, borderWidth, CGRectGetHeight(self.frame))];
        border.backgroundColor = color;
        border.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:border];
    }
}


- (void)setShadowColor:(UIColor *)color
             shadowOffset:(CGSize )size
             shadowRadius:(CGFloat)radius
                    alpha:(CGFloat)alpha {
    
    [self.layer setLayerShadowColor:color shadowOffset:size shadowRadius:radius alpha:alpha];
}

- (void)addSubviews:(NSArray *)views {
    for (id obj in views) {
        [self addSubview:obj];
    }
}
- (void)removeSubviews:(NSArray *)views {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *view in views) {
            [view removeFromSuperview];
        }
    });
    
}

- (void)removeAllSubviews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

#pragma mark - ----------- badge -----------

- (void)shakeView {
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    
    [self.layer addAnimation:shake forKey:nil];
}

- (void)showUIBadge {
    [self showBadgeWithStyle:CCUIViewBadgeStyleRedDot value:0 animationType:CCUIViewBadgeAnimTypeNone];
}

/**
 *  shoUIBadge
 *
 *  @param style UIBadgeStyle type
 *  @param value (if 'style' is UIBadgeStyleRedDot or UIBadgeStyleNew,
 *                this value will be ignored. In this case, any value will be ok.)
 */
- (void)showBadgeWithStyle:(CCUIViewBadgeStyle)style value:(NSInteger)value animationType:(CCUIViewBadgeAnimType)aniType {
    
    self.aniType = aniType;
    switch (style) {
        case CCUIViewBadgeStyleRedDot:
            
            [self __showRedDotBadge];
            break;
        case CCUIViewBadgeStyleNumber:
            
            [self showNumberBadgeWithValue:value];
            break;
        case CCUIViewBadgeStyleNew:
            
            [self __showNeDLBadge];
            break;
        default:
            break;
    }
    
    if (aniType != CCUIViewBadgeAnimTypeNone) {
        
        [self beginAnimation];
    }
}

/**
 *  clear badge
 */
- (void)clearBadge {
    self.badge.hidden = YES;
}

- (void)__showRedDotBadge {
    
    [self __badgeInit];
    //如果标志已经显示,此外,没有红点的风格,我们必须更新UI.
    if (self.badge.tag != CCUIViewBadgeStyleRedDot) {
        self.badge.text = @"";
        self.badge.tag = CCUIViewBadgeStyleRedDot;
        self.badge.layer.cornerRadius = self.badge.width / 2;
    }
    self.badge.hidden = NO;
}

- (void)__showNeDLBadge {
    
    [self __badgeInit];
    //如果标志已经显示,此外,没有红点的风格,我们必须更新UI.
    if (self.badge.tag != CCUIViewBadgeStyleNew) {
        self.badge.text = @"new";
        self.badge.tag = CCUIViewBadgeStyleNew;
        self.badge.width = 20;
        self.badge.height = 13;
        self.badge.center = CGPointMake(self.width, 0);
        self.badge.font = [UIFont boldSystemFontOfSize:9];
        self.badge.layer.cornerRadius = self.badge.height / 3;
    }
    self.badge.hidden = NO;
}

- (void)showNumberBadgeWithValue:(NSInteger)value {
    
    if (value < 0) {
        return;
    }
    [self __badgeInit];
    if (self.badge.tag != CCUIViewBadgeStyleNumber) {
        self.badge.tag = CCUIViewBadgeStyleNumber;
        
        //maximun value allowed is 99. When the value is greater than 99, "99+" will be shown.
        if (value >=100) {
            self.badge.text = @"99+";
        } else {
            self.badge.text = [NSString stringWithFormat:@"%@", @(value)];
        }
        [self adjustLabelWidth:self.badge];
        self.badge.width = self.badge.width - 4;
        self.badge.height = 12;
        if (self.badge.width < self.badge.height) {
            self.badge.width = self.badge.height;
        }
        
        self.badge.center = CGPointMake(self.width, 0);
        self.badge.font = [UIFont boldSystemFontOfSize:9];
        self.badge.layer.cornerRadius = self.badge.height / 2;
    }
    self.badge.hidden = NO;
}

//lazy loading
- (void)__badgeInit {
    
    if (self.badgeBgColor == nil) {
        self.badgeBgColor = [UIColor redColor];
    }
    if (self.badgeTextColor == nil) {
        self.badgeTextColor = [UIColor whiteColor];
    }
    if (nil == self.badge) {
        CGFloat redotWidth = 8;
        CGRect frm = CGRectMake(self.width, -redotWidth, redotWidth, redotWidth);
        self.badge = [[UILabel alloc] initWithFrame:frm];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.center = CGPointMake(self.width, 0);
        self.badge.backgroundColor = self.badgeBgColor;
        self.badge.textColor = self.badgeTextColor;
        self.badge.text = @"";
        self.badge.tag = CCUIViewBadgeStyleRedDot;//red dot by default
        self.badge.layer.cornerRadius = self.badge.width / 2;
        self.badge.layer.masksToBounds = YES;//very important
        [self addSubview:self.badge];
    }
}


#pragma mark --  <other private methods>

- (void)adjustLabelWidth:(UILabel *)label {
    
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [UIFont fontWithName:@"Arial" size:label.font.pointSize];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = label.frame;
    frame.size = labelsize;
    [label setFrame:frame];
}

#pragma mark -- <animation>

//如果你想添加徽章动画类型, 遵循步骤:
//1. 去UIBadgeAnimType和添加新类型的定义
//2. 去一类CAAnimation + WAnimation添加新的动画界面
//3. call that new interface here
- (void)beginAnimation {
    
    if (self.aniType == CCUIViewBadgeAnimTypeBreathe) {
        
        [self.badge.layer addAnimation:[CAAnimation opacityForeverAnimation:1.4]
                                forKey:kBadgeBreatheAniKey];
        
    } else if (self.aniType == CCUIViewBadgeAnimTypeShake) {
        
        [self.badge.layer addAnimation:[CAAnimation shake_AnimationRepeatTimes:MAXFLOAT
                                                                         durTimes:1
                                                                           forObj:self.badge.layer]
                                forKey:kBadgeShakeAniKey];
        
    } else if (self.aniType == CCUIViewBadgeAnimTypeScale) {
        
        [self.badge.layer addAnimation:[CAAnimation scaleFrom:1.4
                                                         toScale:0.6
                                                        durTimes:1
                                                             rep:MAXFLOAT]
                                forKey:kBadgeScaleAniKey];
    }
}


#pragma mark -- <setter/getter>

- (UILabel *)badge {
    
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadge:(UILabel *)label {
    
    objc_setAssociatedObject(self, &badgeLabelKey, label, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)badgeBgColor {
    
    return objc_getAssociatedObject(self, &badgeBgColorKey);
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor {
    
    objc_setAssociatedObject(self, &badgeBgColorKey, badgeBgColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)badgeTextColor {
    
    return objc_getAssociatedObject(self, &badgeTextColorKey);
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN);
}

- (CCUIViewBadgeAnimType)aniType {
    
    id obj = objc_getAssociatedObject(self, &badgeAniTypeKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj integerValue];
    }
    else
        return CCUIViewBadgeAnimTypeNone;
}

- (void)setAniType:(CCUIViewBadgeAnimType)aniType {
    
    NSNumber *numObj = @(aniType);
    objc_setAssociatedObject(self, &badgeAniTypeKey, numObj, OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)badgeFrame {
    
    NSArray * obj = objc_getAssociatedObject(self, &badgeFrameJey);
    if (obj != nil && [obj isKindOfClass:[NSArray class]] && [obj count] == 4 ) {
        
        CGFloat x = [obj[0] floatValue];
        CGFloat y = [obj[1] floatValue];
        CGFloat width = [obj[2] floatValue];
        CGFloat height = [obj[3] floatValue];
        return  CGRectMake(x, y, width, height);
    } else
        
        return CGRectZero;
}

- (void)setBadgeFrame:(CGRect)badgeFrame {}


#pragma mark - ----------- animate -----------
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option {
    [self moveTo:destination duration:secs option:option delegate:nil callback:nil];
    
}

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             
                             [delegate performSelector:method];
                         }
                     }];
}


- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack {
    
    [self raceTo:destination withSnapBack:withSnapBack delegate:nil callback:nil];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method {
    
    CGPoint stopPoint = destination;
    if (withSnapBack) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        } else if (diffx > 0) {
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        } else if (diffy > 0) {
            stopPoint.y += 10.0;
        }
    }
    
    // Do the animation
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectMake(stopPoint.x, stopPoint.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (withSnapBack) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
                                              }
                                              completion:^(BOOL finished) {
                                                  
                                                  [delegate performSelector:method];
                                              }];
                         } else {
                             
                             [delegate performSelector:method];
                         }
                     }];
}


- (void)rotate:(int)degrees duration:(NSTimeInterval)duration delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(degrees));
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             
                             [delegate performSelector:method];
                         }
                     }];
}

- (void)scaleDuration:(NSTimeInterval)duration x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             
                             [delegate performSelector:method];
                         }
                     }];
}

- (void)spinClockwise:(NSTimeInterval)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(90));
                     }
                     completion:^(BOOL finished) {
                         [self spinClockwise:secs];
                     }];
}

- (void)spinCounterClockwise:(NSTimeInterval)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(270));
                     }
                     completion:^(BOOL finished) {
                         [self spinCounterClockwise:secs];
                     }];
}

- (void)AnimationCurlDownFromDuration:(NSTimeInterval)duration {
    [UIView transitionWithView:self duration:duration
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setAlpha:1.0]; }
                    completion:nil];
}

- (void)AnimationCurlUpFromDuration:(NSTimeInterval)duration {
    [UIView transitionWithView:self duration:duration
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setAlpha:0]; }
                    completion:nil];
}

- (void)AlphaFormDuration:(NSTimeInterval)duration alpha:(CGFloat)alpha {
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = alpha;
                     }
                     completion:nil];
}
- (void)SparklDuration:(float)duration isLoop:(BOOL)isLoop {
    [UIView animateWithDuration:duration/2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        // 不完全的淡出
        self.alpha = 0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration/2 delay:0.0 options:UIViewAnimationOptionCurveLinear    animations:^{
            // 淡入
            self.alpha = 1.0;
        }   completion:^(BOOL finished) {
            if (isLoop) {
                [self SparklDuration:duration isLoop:isLoop];
                
            }
            
        }];
        
    }];
    
}


- (void)addSubview:(UIView *)view alphaAnimationDuration:(NSTimeInterval)duration {
    [self addSubview:view];
    
    __block CGFloat finalAlpha = view.alpha;
    
    view.alpha = 0.0;
    __block typeof(view) blockView = view;
    [UIView animateWithDuration:duration animations:^{
        blockView.alpha = finalAlpha;
    }];
}

#pragma mark - ----------- UITapGestureRecognizer -----------
- (void)addTargetForOpenRecognizer:(BOOL)isOpen ActionrRespond:(GestureActionBlock)action {
    
    //判断对象是否属于某个类 或者 子类
    if ([self isKindOfClass:[UIControl class]] || [self isKindOfClass:[UIButton class]] || [self isMemberOfClass:[UIControl class]] || [self isMemberOfClass:[UIButton class]]) {
        return;
    }
    if (isOpen == YES) {
        UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
        if (!gesture) {
            gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__targetActionResponder:)];
            [self addGestureRecognizer:gesture];
            //利用block回调来处理点击操作(这个操作会retain一个Tap)
            objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
        }
        //利用block回调来处理点击操作(这个操作会copy一份Tap)
        objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, action, OBJC_ASSOCIATION_COPY);
        
    } else {
        NSLog(@"%@ 未开启isOpen",NSStringFromClass([self class]));
        objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}


- (void)__targetActionResponder:(UITapGestureRecognizer*)gesture {
    
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            
            block(gesture);
        }
    }
}

- (void)addTongForOpenRecognizer:(BOOL)isOpen ActionrRespond:(GestureActionBlock)action {
    //判断对象是否属于某个类 或者 子类
    if ([self isKindOfClass:[UIControl class]] || [self isKindOfClass:[UIButton class]] || [self isMemberOfClass:[UIControl class]] || [self isMemberOfClass:[UIButton class]]) {
        return;
    }
    if (isOpen == YES) {
        UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
        if (!gesture) {
            
            gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__tongTouchActionResponder:)];
            [self addGestureRecognizer:gesture];
            objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
        }
        objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, action, OBJC_ASSOCIATION_COPY);
        
    } else {
        NSLog(@"%@ 未开启isOpen",NSStringFromClass([self class]));
        objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (void)__tongTouchActionResponder:(UITapGestureRecognizer*)gesture {
    
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block) {
            
            block(gesture);
        }
    }
}

- (UIViewController *)firstResponderViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]]) {
        
        responder = [responder nextResponder];
    }
    
    return (UIViewController *)responder;
}

@end


@implementation UIView (CCCategory_UINib)

+ (instancetype)nibWithFrame:(CGRect)frame {
    NSString *className = NSStringFromClass([self class]);
    UIView *nibView = [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil] firstObject];
    if (nibView) {
        nibView.frame = frame;
    } else {
        NSLog(@"%s：从xib创建视图失败，当前类是：%@",__FUNCTION__,className);
    }
    return nibView;
}

@end



@implementation UIView (EffectView)

/** 设置Effect效果 */
- (void)setEffectWithStyle:(UIBlurEffectStyle)effectStyle {
    [self setEffectWithStyle:effectStyle backgroundImage:nil];
}
- (void)setEffectWithStyle:(UIBlurEffectStyle)effectStyle backgroundImage:(UIImage *)backgroundImage {
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:effectStyle]];
    blurEffectView.frame = self.bounds;
    if (backgroundImage) {
        [self insertSubview:blurEffectView atIndex:1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
        imageView.cornerRadius = YES;
        imageView.frame = self.bounds;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:imageView atIndex:0];
    } else {
        [self insertSubview:blurEffectView atIndex:0];
    }
    
}

@end
