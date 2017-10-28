//
//  SSDefaultMessageView.m
//  CZOL
//
//  Created by 李飞恒 on 2017/10/28.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSDefaultMessageView.h"

@interface SSDefaultMessageView ()

@property (nonatomic, strong) NSTimer *timer;

@end
@implementation SSDefaultMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.defaultImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.textLabel];
        [self addSubview:self.touch];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (UIImageView *)defaultImageView
{
    if (!_defaultImageView) {
        _defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height*0.1, self.width, self.width*0.2)];
        _defaultImageView.centerX = self.centerX;
        _defaultImageView.contentMode = UIViewContentModeScaleAspectFit;
        _defaultImageView.backgroundColor = kColorClear;
        _defaultImageView.image = [UIImage imageNamed:@"Content_CharmValue"];
    }
    return _defaultImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.defaultImageView.maxY+16, self.width, 21)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kTitleColor;
    }
    return _titleLabel;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.maxY+16, self.width, 32)];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 2;
        _textLabel.textColor = kTitleColor;
    }
    return _textLabel;
}


- (UIButton *)touch
{
    if (!_touch) {
        _touch = [[UIButton alloc] initWithFrame:CGRectMake(0, self.textLabel.maxY+(self.height*0.1), self.width*0.3, 32)];
        _touch.centerX = self.centerX;
        [_touch setTitle:kLocalized(@"重新加载") forState:(UIControlStateNormal)];
        [_touch setTitleColor:kTitleColor forState:(UIControlStateNormal)];
        _touch.titleLabel.font = [UIFont systemFontOfSize:12];
        _touch.layer.cornerRadius = 4;
        _touch.layer.masksToBounds = YES;
        _touch.layer.borderColor = kTitleColor1.CGColor;
        _touch.layer.borderWidth = 0.5;
        [_touch addTarget:self action:@selector(touchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _touch;
}

- (void)touchAction:(UIButton *)event
{
    int x = arc4random() % ([self images].count);
    [self.defaultImageView setImage:[self images][x]];
    
    if ([self.delegate respondsToSelector:@selector(didSelectAction:)]) {
        [self.delegate didSelectAction:event];
    }
}

- (void)action
{
    int x = arc4random() % ([self images].count);
    [self.defaultImageView setImage:[self images][x]];
}

- (NSArray *)images
{
    UIImage *image1 = [UIImage imageNamed:@"Content_Awesomeness"];
    UIImage *image2 = [UIImage imageNamed:@"Content_Big name"];
    UIImage *image3 = [UIImage imageNamed:@"Content_captain"];
    UIImage *image4 = [UIImage imageNamed:@"Content_EmergingForce"];
    UIImage *image5 = [UIImage imageNamed:@"Content_Entering"];
    
    UIImage *image6 = [UIImage imageNamed:@"Content_GoldMedal"];
    UIImage *image7 = [UIImage imageNamed:@"Content_K"];
    UIImage *image8 = [UIImage imageNamed:@"Content_NewMan"];
    UIImage *image9 = [UIImage imageNamed:@"Content_Prophet"];
    UIImage *image10 = [UIImage imageNamed:@"Content_RisingStar"];
    
    UIImage *image11 = [UIImage imageNamed:@"Content_Rookie"];
    UIImage *image12 = [UIImage imageNamed:@"Content_Shookontent"];
    UIImage *image13 = [UIImage imageNamed:@"Content_sin"];
    UIImage *image14 = [UIImage imageNamed:@"Content_SplendidStar"];
    UIImage *image15 = [UIImage imageNamed:@"Content_super"];
    
    UIImage *image16 = [UIImage imageNamed:@"Content_SuperIdol"];
    UIImage *image17 = [UIImage imageNamed:@"Content_Superstar"];
    UIImage *image18 = [UIImage imageNamed:@"Content_Tomorrow"];
    UIImage *image19 = [UIImage imageNamed:@"Content_Warlords"];
    UIImage *image20 = [UIImage imageNamed:@"Content_Wudu"];
    
    return @[image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12,image13,image14,image15,image16,image17,image18,image19,image20];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
