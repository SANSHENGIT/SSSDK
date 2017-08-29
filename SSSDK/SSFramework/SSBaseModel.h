//
//  SSBaseModel.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSManager.h"

@interface SSBaseModel : SSManager

/**
 字典转对象
 */
+ (instancetype)objWithDic:(NSDictionary *)dic;

/**
 Json转对象
 */
+ (instancetype)objWithJson:(id)json;

/**
 对象转Json
 */
- (instancetype)objToJson;


/**
 对象转JsonData
 */
- (NSData *)objToJSONData;


/**
 对象转JsonString
 */
- (NSString *)objToJSONString;


/**
 判断两个Model是否相同
 */
- (BOOL)objIsEqual:(id)model;


@end
