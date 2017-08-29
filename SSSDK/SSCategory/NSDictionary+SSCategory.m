//
//  NSDictionary+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "NSDictionary+SSCategory.h"

@implementation NSDictionary (SSCategory)

//- (NSString *)descriptionWithLocale:(id)locale {
//    NSMutableString *str = [NSMutableString string];
//
//    [str appendString:@"{\n"];
//
//    // 遍历字典的所有键值对
//    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [str appendFormat:@"\t%@ = %@,\n", key, obj];
//    }];
//
//    [str appendString:@"}"];
//
//    // 查出最后一个,的范围
//    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
//    if (range.length) {
//        // 删掉最后一个,
//        [str deleteCharactersInRange:range];
//    }
//
//    return str;
//}


- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}


@end
