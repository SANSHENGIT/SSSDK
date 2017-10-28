//
//  SSDefaultMessageView.h
//  CZOL
//
//  Created by 李飞恒 on 2017/10/28.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSDefaultMessageViewDelegate <NSObject>

- (void)didSelectAction:(UIButton *)evet;

@end
@interface SSDefaultMessageView : UIView

@property (nonatomic, assign) id <SSDefaultMessageViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *defaultImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIButton *touch;

@end
