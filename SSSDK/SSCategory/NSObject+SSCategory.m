//
//  NSObject+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "NSObject+SSCategory.h"
#import <objc/runtime.h>

@implementation NSObject (SSCategory)

+ (BOOL)objSELWith:(SEL)oldSEL toSEL:(SEL)newSEL {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, oldSEL);
    Method newMethod = class_getInstanceMethod(class, newSEL);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

- (void)setAssociateValue:(id)value withKey:(void *)key {
    //指定引用对象
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)setAssiatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

@end
