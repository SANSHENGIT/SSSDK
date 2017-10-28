//
//  SSView.h
//  chizhaonline
//
//  Created by 李飞恒 on 2017/9/1.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSView : UIView

/**
 截图，快照

 @param frame 快照尺寸
 */
- (UIImage *)takeSnapshot:(CGRect )frame;

@end
