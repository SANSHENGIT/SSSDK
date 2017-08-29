//
//  SSHTTPRequestCenter.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSHTTPRequestCenter.h"

@implementation SSHTTPRequestCenter

static NSString *_baseUrl = @"";
static AFSSLPinningMode _pinningMode = AFSSLPinningModeNone;
static SSHTTPRequestCenter *_sharedCenter = nil;

+ (instancetype)sharedCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        _sharedCenter = [[SSHTTPRequestCenter alloc] initWithBaseURL:[NSURL URLWithString:_baseUrl] sessionConfiguration:sessionConfiguration];
        _sharedCenter.securityPolicy = [AFSecurityPolicy policyWithPinningMode:_pinningMode];
    });
    return _sharedCenter;
}

+ (void)baseUrl:(NSString *)baseUrl {
    _baseUrl = baseUrl;
}

+ (void)policyWithPinningMode:(AFSSLPinningMode)pinningMode {
    _pinningMode = pinningMode;
}

@end
