//
//  SSPOPView.m
//  CZOLAPIDebug
//
//  Created by 李飞恒 on 2017/10/17.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSPOPView.h"

@implementation SSPOPView

static SSPOPView *popView = nil;

+ (instancetype)singleInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popView = [[[self class] alloc] initWithFrame:[UIScreen mainScreen].bounds];
        popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    });
    return popView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    [popView.window setWindowLevel:UIWindowLevelNormal];
    [popView setHidden:NO];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [popView setHidden:YES];
    
    [self dismissView];
}

- (void)dismissView
{
    
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
