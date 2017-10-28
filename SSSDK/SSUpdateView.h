//
//  SSUpdateView.h
//  CZOLAPIDebug
//
//  Created by 李飞恒 on 2017/10/17.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPOPView.h"

@interface SSUpdateView : SSPOPView

@property (nonatomic, strong) UIView *centreView;

@property (nonatomic, strong) UIButton *update;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextView *textView;

+ (instancetype)singleInstance;

@end
