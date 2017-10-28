//
//  SSTransformCell.h
//  chizhaonline
//
//  Created by 李飞恒 on 2017/9/7.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSTableViewCell.h"

/**
 Folding animation types
 
 - SSTransformAnimationOpen:  Open  direction
 - SSTransformAnimationOpen:  Close direction
 */
typedef NS_ENUM (NSInteger,  SSTransformAnimationType) {
    SSTransformAnimationOpen,
    SSTransformAnimationClose
};

typedef void (^animationCompletion)(NSError *error);
typedef void (^FoldTapHandlerBlock)();

@interface AnimationView : UIView <CAAnimationDelegate>

@property (nonatomic) AnimationView *backView;

- (void)addBackViewHeight:(CGFloat)height color:(UIColor *)color;

-(void)foldingAnimation:(NSString *)timing from:(CGFloat)from to:(CGFloat)to delay:(NSTimeInterval)delay  duration:(NSTimeInterval)durtion hidden:(BOOL)hidden;

@end

@interface SSTransformCell : SSTableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewTopConstraint;

@property (weak, nonatomic) IBOutlet AnimationView *foregroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foregroundTopConstraint;
@property (strong, nonatomic) UIView *animationView;



@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UIImageView *foldTestImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (BOOL)isAnimating;

- (CGFloat)returnSumTime;

- (void)fold_imageTap:(FoldTapHandlerBlock)handler;

/** Open or close cell */
- (void)selectedAnimation:(BOOL)selected animation:(BOOL)animated completion:(animationCompletion)completion;


@end
