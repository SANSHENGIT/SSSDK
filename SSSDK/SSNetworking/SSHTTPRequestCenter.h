//
//  SSHTTPRequestCenter.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SSHTTPRequestCenter : AFHTTPSessionManager

+ (void)baseUrl:(NSString *)baseUrl;

+ (void)policyWithPinningMode:(AFSSLPinningMode)pinningMode;

+ (instancetype)sharedCenter;

@end
