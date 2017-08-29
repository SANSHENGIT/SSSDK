//
//  NSString+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <GTMBase64.h>
#import <UIKit/UIKit.h>


#define kInitIv @"12345678"

@interface NSString (SSCategory)

/*
 *  时间戳对应的NSDate
 */
@property (nonatomic,strong,readonly) NSDate *date;

/** 将JSON->NSString */
- (NSString *)stringWithJSON;

//加密 kInitIv = @"12345678"
- (NSString *)encryptWithKey:(NSString*)aKey;
//解密 kInitIv = @"12345678"
- (NSString *)decryptWithKey:(NSString *)aKey;

/**
 将字符串转成MD5
 */
- (NSString *)MD5Hex;

//+ (NSString*)sha256:(NSString *)stringpass;

/**
 *  从16进制的字符串格式转换为NSData
 *  @return NSData
 */
- (NSData *)hexStringToData;


/**
 *  移除字符串最后一个字符(非空格)
 *  @return 返回一个新的字符串
 */
- (NSString *)deleteRangeLastOne;

/**
 *  移除字符串首尾各一个字符
 *  @return 返回一个新的字符串
 */
- (NSString *)deleteLastCharacterFirst;



/**
 *
 *	传入user_id经过解密后返回前8位的密码
 *	@param input	需要解密的字符串
 *	@return 返回一个解密后的字符串
 */
+ (NSString*)digest:(NSString*)input;



/*! 根据固定宽,计算Size */
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGSize)sizeWithFont:(UIFont *)font forSize:(CGSize)size;
- (CGSize)sizeWithFont:(UIFont *)font forWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font forHeight:(CGFloat)height;



- (NSString *)getOriginalImageURL;

/**
 *  使用CoreFoundation 将string to UTF-8
 *  @param input 需要转码的string
 *  @return UTF-8编码
 */
- (NSString *)encodeToPercentEscapeString:(NSString *)input;

/** 是否是正确的手机号 */
- (BOOL)ss_isMobileNumber;

/** 是否是6位数字 */
- (BOOL)ss_isNumberOf6;

/** 
 是否是符合要求的密码
 (^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$)
 */
- (BOOL)ss_isRightPwd;

/** 正则匹配用户身份证号15或18位 */
- (BOOL)ss_isRightIdCard;

/** 判断银行卡号是否合法 */
- (BOOL)ss_isBankCard;

/** 获取设备的UDID */
+ (NSString *)UUID;

@end
