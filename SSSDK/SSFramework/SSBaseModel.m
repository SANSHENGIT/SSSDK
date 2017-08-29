//
//  SSBaseModel.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSBaseModel.h"
#import <YYModel.h>
#import <YYClassInfo.h>

@implementation SSBaseModel

+ (instancetype)objWithDic:(NSDictionary *)dic
{
    return [SSBaseModel yy_modelWithDictionary:dic];
}

+ (instancetype)objWithJson:(id)json
{
    return [SSBaseModel yy_modelWithJSON:json];
}

- (instancetype)objToJson
{
    return [self yy_modelToJSONObject];
}

- (NSData *)objToJSONData
{
    return [self yy_modelToJSONData];
}
- (NSString *)objToJSONString
{
    return [self yy_modelToJSONString];
}

- (BOOL)objIsEqual:(id)model
{
    return [self yy_modelIsEqual:model];
}


@end
