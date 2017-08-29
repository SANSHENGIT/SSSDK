//
//  NSObject+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SSCategory)

/**
 *  交换两个方法的实现
 *
 *  @param oldSEL 原来的方法
 *  @param newSEL      新的方法
 *
 *  @return 是否交换成功
 */
+ (BOOL)objSELWith:(SEL)oldSEL toSEL:(SEL)newSEL;

- (void)setAssociateValue:(id)value withKey:(void *)key;/** 设置指定对象 */

- (id)setAssiatedValueForKey:(void *)key;/** 从key中获取指定对象 */


@end
