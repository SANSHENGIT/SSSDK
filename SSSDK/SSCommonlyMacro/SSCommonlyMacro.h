//
//  SSCommonlyMacro.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/30.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#ifndef SSCommonlyMacro_h
#define SSCommonlyMacro_h

#define kWidth  ([UIScreen mainScreen].bounds.size.width)
#define kHeight ([UIScreen mainScreen].bounds.size.height)
#define kBounds ([UIScreen mainScreen].bounds)
#define kSize   ([UIScreen mainScreen].bounds.size)



//ios系统版本
#define ios8x  (([[[UIDevice currentDevice] systemVersion] floatValue]) >=8.0f)
#define ios7x  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f

#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)
#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)
#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)
#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)



/**
 十六进制颜色 + 透明度
 */
#define kColorHexAlpha(colorV,a) [UIColor colorWithHexColorString:@#colorV alpha:a]

/**
 十六进制颜色
 */
#define kColorHex(str) ([UIColor colorWithString:str])


/**
 NSNumber 转 NSString
 */
#define kStringFromInteger(i) [NSString stringWithFormat:@"%@",@(i)]

/**
 透明色
 */
#define kColorClear  ([UIColor clearColor])

/**
 国际化调用
 @param key 文字
 */
#define SSLocalized(key) (NSLocalizedString(key, nil))


#define __WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define __StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;


#ifdef DEBUG
#   define SSLog(fmt, ...) NSLog((fmt),##__VA_ARGS__)
#   define SSFunctionLog NSLog(@"%s : %d",__FUNCTION__,__LINE__)
#   define SSLogVerbose(frmt, ...) LOG_OBJC_MAYBE(LOG_ASYNC_VERBOSE, LOG_LEVEL_DEF, LOG_FLAG_VERBOSE, 0, frmt, ##__VA_ARGS__)



#else
#   define SSLog(...)
#endif


#endif /* SSCommonlyMacro_h */
