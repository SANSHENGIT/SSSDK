//
//  UITableViewCell+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "UITableViewCell+SSCategory.h"

@implementation UITableViewCell (SSCategory)

+ (instancetype)cellNibWithFrmae:(CGRect)frame {
    UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    [cell setFrame:frame];
    return cell;
}


@end
