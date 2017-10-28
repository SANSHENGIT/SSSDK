//
//  SSView.m
//  chizhaonline
//
//  Created by 李飞恒 on 2017/9/1.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSView.h"

@implementation SSView

- (UIImage *)takeSnapshot:(CGRect )frame {
    UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, frame.origin.x * -1, frame.origin.y * -1);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    if (!currentContext) {
        return nil;
    }
    
    [self.layer renderInContext:currentContext];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
