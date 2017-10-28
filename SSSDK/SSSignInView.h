//
//  SSSignInView.h
//  CZOL
//
//  Created by 李飞恒 on 2017/10/17.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//




@interface SSSignInView : UIView

@property (nonatomic, strong) UIView *centreView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *signIn;

- (void)show;

- (void)dismissView;

- (void)setTitle:(NSString *)title;

@end
