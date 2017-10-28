//
//  SSTransformCell.m
//  chizhaonline
//
//  Created by 李飞恒 on 2017/9/7.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSTransformCell.h"

@interface SSTransformCell ()
{
    NSMutableArray *animationItemViews;
    UIColor *backViewColor;
    FoldTapHandlerBlock tapHandler;
}
@property (nonatomic) NSLayoutConstraint *containerViewTop;

@end

@implementation SSTransformCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.foregroundView.layer.cornerRadius = 10;
    self.foregroundView.layer.masksToBounds = YES;
    
    backViewColor = [UIColor colorWithRed:0.9686 green:0.9333 blue:0.9686 alpha:1.0];
    [self configureDefaultState];
    animationItemViews = [self createAnimationItemView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageViewToFriendDetailView:)];
    self.coverImageView.userInteractionEnabled = YES;
    [self.coverImageView addGestureRecognizer:tap];
}

- (void)closeAnimation:(animationCompletion)completion
{
    NSArray *durations = [self durationSequence];
    durations = [[durations reverseObjectEnumerator] allObjects];
    NSTimeInterval delay = 0;
    NSString *timing = kCAMediaTimingFunctionEaseIn;
    CGFloat from = 0.0;
    CGFloat to = M_PI / 2;
    BOOL hidden = YES;
    [self configureAnimationItems:SSTransformAnimationClose];
    for (int index = 0; index < animationItemViews.count; index++) {
        float duration = [durations[index] floatValue];
        NSArray *tempArray = [[animationItemViews reverseObjectEnumerator] allObjects];
        AnimationView *animatedView = tempArray[index];
        [animatedView foldingAnimation:timing from:from to:to delay:delay duration:duration hidden:hidden];
        
        from = from == 0.0 ? -M_PI / 2 : 0.0;
        to = to == 0.0 ? M_PI / 2 : 0.0;
        timing = timing == kCAMediaTimingFunctionEaseIn ? kCAMediaTimingFunctionEaseOut : kCAMediaTimingFunctionEaseIn;
        hidden = !hidden;
        delay += duration;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.containerView.alpha = 0;
        if (completion) {
            completion(nil);
        }
    });
    
    AnimationView *firstItemView;
    for (UIView *tempView in self.containerView.subviews) {
        if (tempView.tag == 0) {
            firstItemView = (AnimationView *)tempView;
        }
        
        float value = (delay - [[durations lastObject] floatValue] * 1.5);
        NSLog(@"%f",value);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(value * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
    }
}

- (void)openAnimation:(animationCompletion)completion
{
    NSArray *durtions = [self durationSequence];
    NSTimeInterval delay = 0;
    NSString *timing = kCAMediaTimingFunctionEaseIn;
    CGFloat from = 0.0;
    CGFloat to = -M_PI / 2;
    BOOL hidden = YES;
    [self configureAnimationItems:SSTransformAnimationOpen];
    
    for (int index = 0; index < animationItemViews.count; index++) {
        float duration = [durtions[index] floatValue];
        AnimationView *animatedView = animationItemViews[index];
        [animatedView foldingAnimation:timing from:from to:to delay:delay duration:duration hidden:hidden];
        from = from == 0 ? M_PI / 2 : 0.0;
        to = to == 0.0 ? -M_PI / 2 : 0.0;
        timing = timing == kCAMediaTimingFunctionEaseIn ? kCAMediaTimingFunctionEaseOut : kCAMediaTimingFunctionEaseIn;
        hidden = !hidden;
        delay += duration;
    }
    for (UIView *view in self.containerView.subviews) {
        if (view.tag == 0) {
            AnimationView *firstItemView = (AnimationView *)view;
            firstItemView.layer.masksToBounds = YES;
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:firstItemView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            firstItemView.layer.mask = maskLayer;
        } else if (view.tag == 3) {
            AnimationView *lastItemView = (AnimationView *)view;
            lastItemView.layer.masksToBounds = YES;
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lastItemView.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            lastItemView.layer.mask = maskLayer;
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([durtions[0] floatValue] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion(nil);
        }
    });
}

/**
 Open or close cell
 
 - parameter selected: Specify true if you want to open cell or false if you close cell.
 - parameter animated: Specify true if you want to animate the change in visibility or false if you want immediately.
 - parameter completion: A block object to be executed when the animation sequence ends.
 */
- (void)selectedAnimation:(BOOL)selected animation:(BOOL)animated completion:(animationCompletion)completion
{
    if (selected) {
        self.containerView.alpha = 1;
        for (UIView *subView in self.containerView.subviews) {
            subView.alpha = 1;
        }
        
        if (animated) {
            [self openAnimation:completion];
        } else {
            self.foregroundView.alpha = 0;
            for (UIView *subView in self.containerView.subviews) {
                if ([subView isKindOfClass:[AnimationView class]]) {
                    AnimationView *rotateView = (AnimationView *)subView;
                    rotateView.backView.alpha = 0;
                }
            }
        }
    } else {
        //关闭状态
        if (animated) {
            [self closeAnimation:completion];
        } else {
            self.foregroundView.alpha = 1;
            self.containerView.alpha = 0;
        }
    }
}

- (BOOL)isAnimating
{
    for (UIView *item in animationItemViews) {
        if (item.layer.animationKeys.count > 0) return YES;
    }
    return NO;
}

- (void)fold_imageTap:(FoldTapHandlerBlock)handler
{
    tapHandler = handler;
}

- (NSMutableArray *)durationSequence
{
    NSMutableArray *durationArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithFloat:0.35], [NSNumber numberWithFloat:0.23], [NSNumber numberWithFloat:0.23], nil];
    NSMutableArray *durtions = [NSMutableArray array];
    for (int index = 0; index < self.containerView.subviews.count - 1; index++) {
        NSNumber *tempDuration = durationArray[index];
        float temp = [tempDuration floatValue] / 2;
        NSNumber *duration = [NSNumber numberWithFloat:temp];
        
        [durtions addObject:duration];
        [durtions addObject:duration];
    }
    return durtions;
}

- (CGFloat)returnSumTime
{
    NSMutableArray *tempArray = [self durationSequence];
    CGFloat sumTime = 0.0;
    for (NSNumber *number in tempArray) {
        CGFloat time = [number floatValue];
        sumTime += time;
    }
    return sumTime;
}

- (void)tapImageViewToFriendDetailView:(UITapGestureRecognizer *)sender
{
    if (tapHandler) {
        tapHandler();
    }
}

- (NSMutableArray *)createAnimationItemView
{
    NSMutableArray *items = [NSMutableArray array];
    NSMutableArray *AnimationViews = [NSMutableArray array];
    
    [items addObject:self.foregroundView];
    
    for (UIView *itemView in self.containerView.subviews) {
        if ([itemView isKindOfClass:[AnimationView class]]) {
            AnimationView *tempView = (AnimationView *)itemView;
            [AnimationViews addObject:tempView];
            if (tempView.backView != nil) [AnimationViews addObject:tempView.backView];
        }
    }
    [items addObjectsFromArray:AnimationViews];
    return items;
}

- (void)configureAnimationItems:(SSTransformAnimationType)animationType
{
    if (animationType == SSTransformAnimationOpen) {
        for (UIView *view in self.containerView.subviews) {
            if ([view isKindOfClass:[AnimationView class]]) {
                view.alpha = 0;
            }
        }
    } else {
        for (UIView *view in self.containerView.subviews) {
            if (![view isKindOfClass:[AnimationView class]]) return;
            AnimationView *tempRotaView = (AnimationView *)view;
            if (animationType == SSTransformAnimationOpen) {
                tempRotaView.alpha = 0;
            } else {
                tempRotaView.alpha = 1;
                tempRotaView.backView.alpha = 0;
            }
        }
    }
}

//设置初始状态
- (void)configureDefaultState
{
    self.containerViewTopConstraint.constant = _foregroundTopConstraint.constant;
    self.containerView.alpha = 0;
    
    //将第一个图设置成圆角
    UIView *firstItemView;
    for (UIView *v in self.containerView.subviews) {
        if (v.tag == 0) {
            firstItemView = v;
        }
    }
    
    //设置外层图片属性
    self.foregroundView.layer.anchorPoint = CGPointMake(0.5, 1);
    
    self.foregroundTopConstraint.constant += self.foregroundView.bounds.size.height / 2;
    self.foregroundView.layer.transform = [self transform3d];
    [self.contentView bringSubviewToFront:self.foregroundView];
    
    for (NSLayoutConstraint *constraint in self.containerView.constraints) {
        if ([constraint.identifier isEqualToString:@"yPosition"]) {
            constraint.constant -= [constraint.firstItem layer].bounds.size.height / 2;
            [constraint.firstItem layer].anchorPoint = CGPointMake(0.5, 0);
            [constraint.firstItem layer].transform = [self transform3d];
        }
    }
    
    //添加背景View
    AnimationView *previusView;
    for (UIView *sub in self.containerView.subviews) {
        if (sub.tag > 0 && [sub isKindOfClass:[AnimationView class]]) {
            AnimationView *tempView = (AnimationView *)sub;
            [previusView addBackViewHeight:tempView.bounds.size.height color:backViewColor];
            previusView = tempView;
        }
    }
}

//3d偏移属性设置
- (CATransform3D)transform3d
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 2.5 / -2000;
    return transform;
}

@end



@interface AnimationView ()

@property (nonatomic, assign) BOOL hiddenAfterAnimation;

@end

@implementation AnimationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _hiddenAfterAnimation = NO;
}

- (void)rotatedX:(CGFloat)angle
{
    CATransform3D allTransofrom = CATransform3DIdentity;
    CATransform3D rotateTransform = CATransform3DMakeRotation(angle, 1, 0, 0);
    allTransofrom = CATransform3DConcat(allTransofrom, rotateTransform);
    allTransofrom = CATransform3DConcat(allTransofrom, [self transform3d]);
    self.layer.transform = allTransofrom;
}

- (CATransform3D)transform3d
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 2.5 / -2000;
    return transform;
}

- (void)addBackViewHeight:(CGFloat)height color:(UIColor *)color
{
    AnimationView *view = [[AnimationView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = color;
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    view.layer.transform = [self transform3d];
    view.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:view];
    self.backView = view;
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:height]];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:self.bounds.size.height - height + height / 2];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:0];
    
    [self addConstraints:@[top, leading, trailing]];
}

- (void)foldingAnimation:(NSString *)timing from:(CGFloat)from to:(CGFloat)to delay:(NSTimeInterval)delay duration:(NSTimeInterval)durtion hidden:(BOOL)hidden
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:from];
    rotateAnimation.toValue = [NSNumber numberWithFloat:to];
    rotateAnimation.duration = durtion;
    rotateAnimation.delegate = self;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = FALSE;
    rotateAnimation.beginTime = CACurrentMediaTime() + delay;
    
    _hiddenAfterAnimation = hidden;
    
    [self.layer addAnimation:rotateAnimation forKey:@"rotation.x"];
}

#pragma mark - override

- (void)animationDidStart:(CAAnimation *)anim
{
    self.layer.shouldRasterize = YES;
    self.alpha = 1;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_hiddenAfterAnimation) {
        self.alpha = 0;
    }
    [self.layer removeAllAnimations];
    self.layer.shouldRasterize = NO;
}

@end
