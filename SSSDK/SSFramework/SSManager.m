//
//  SSManager.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/28.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSManager.h"


@implementation SSManager

static SSManager *_share = nil;

+ (instancetype)creationShare
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _share = [[super allocWithZone:NULL] init];
    }) ;
    return _share;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [SSManager creationShare];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [SSManager creationShare];
}




@end
