//
//  SSAnimateEQView.m
//  chizhaonline
//
//  Created by 李飞恒 on 2017/9/20.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSAnimateEQView.h"


@interface SSAnimateEQView ()
{
    CGFloat _iHeight;
}
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *barArray;

@property (nonatomic, assign) NSInteger numberOfBars;


@end
@implementation SSAnimateEQView

- (instancetype)initWithNumberOfBars:(NSInteger)numberOfBars barHeight:(CGFloat)height
{
    self = [super init];
    if (self) {
        
        self.numberOfBars = numberOfBars;
        _iHeight = height;
    }
    return self;
}

- (instancetype)initWithNumberOfBars:(int)numberOfBars
{
    return [self initWithNumberOfBars:numberOfBars barHeight:BAR_HEIGHT];
}


- (void)initSubview
{
    self.frame = CGRectMake(0, 0, BAR_PADDING * self.numberOfBars + (BAR_WIDTH * self.numberOfBars), _iHeight);
    NSMutableArray *tempBarArray = [[NSMutableArray alloc]initWithCapacity:self.numberOfBars];
    for(int i = 0; i < self.numberOfBars; i++) {
        UIImageView* bar = [[UIImageView alloc]initWithFrame:CGRectMake(i * BAR_WIDTH+i*BAR_PADDING, 0, BAR_WIDTH, 1)];
        bar.image = [UIImage imageColor:self.barColor];
        [self addSubview:bar];
        [tempBarArray addObject:bar];
    }
    self.barArray = [[NSArray alloc]initWithArray:tempBarArray];
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2*2);
    self.transform = transform;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stop) name:NOTIFICATION_ANIMATE_EQ_STOP_TIMER object:nil];
}

- (UIColor *)barColor
{
    if (!_barColor) {
        _barColor = kDefineColor;
    }
    return _barColor;
}

- (void)start
{
    [self initSubview];
    self.hidden = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(ticker) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stop
{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)ticker
{
    
    [UIView animateWithDuration:.35 animations:^{
        for(UIImageView* bar in self.barArray) {
            CGRect rect = bar.frame;
            rect.size.height = arc4random() % BAR_HEIGHT + 1;
            bar.frame = rect;
        }
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
