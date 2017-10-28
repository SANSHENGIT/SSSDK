//
//  SSUpdateView.m
//  CZOLAPIDebug
//
//  Created by 李飞恒 on 2017/10/17.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSUpdateView.h"

@implementation SSUpdateView

+ (instancetype)singleInstance
{
	return [super singleInstance];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.centreView];
        
        [self.centreView addSubview:self.titleLabel];
        [self.centreView addSubview:self.textView];
        [self.centreView addSubview:self.update];
    }
    return self;
}

- (UIView *)centreView
{
    if (!_centreView) {
        _centreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.7, [UIScreen mainScreen].bounds.size.width)];
        _centreView.center = self.center;
        _centreView.backgroundColor = [UIColor whiteColor];
        _centreView.exclusiveTouch = YES;
        _centreView.multipleTouchEnabled = YES;
    }
    return _centreView;
}

- (UIButton *)update
{
    if (!_update) {
        _update = [[UIButton alloc] initWithFrame:CGRectMake(0, self.centreView.bounds.size.height-44, self.centreView.bounds.size.width, 44)];
        [_update setBackgroundColor:kThemeTitleColor];
        [_update setTitle:NSLocalizedString(@"更新版本", nil) forState:(UIControlStateNormal)];
    }
    return _update;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.centreView.bounds.size.width, 58)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = self.centreView.backgroundColor;
        _titleLabel.layer.cornerRadius = 8;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.text = NSLocalizedString(@"叱咤在线更新版本啦~！", nil);
        
        UIView *link = [[UIView alloc] initWithFrame:CGRectMake(0, _titleLabel.bounds.size.height+1, _titleLabel.bounds.size.width, 0.5)];
        link.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.centreView addSubview:link];
    }
    return _titleLabel;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(self.titleLabel.frame)+2, self.centreView.bounds.size.width-8, self.centreView.bounds.size.height-(CGRectGetMaxY(self.titleLabel.frame))-self.update.bounds.size.height-2)];
        _textView.backgroundColor = self.centreView.backgroundColor;
        _textView.text = @"1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\n\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果\
        1.修改了一些bug\n2.添加订阅功能\n3.更加礼物动画效果";
        
        _textView.editable = NO;
        _textView.selectable = NO;
    }
    return _textView;
}

- (void)dismissView
{
    [super dismissView];
    NSLog(@"%s",__FUNCTION__);
    
    [self.textView resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
