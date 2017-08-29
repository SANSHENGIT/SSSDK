//
//  NSDate+SSCategory.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, NSDateTimerFormat) {
    NSDateTimerFormatA, /** 2016/04/09 */
    NSDateTimerFormatB, /** 2016,04,09 */
    NSDateTimerFormatC /** 2016-04-09 */
};


@interface NSDate (SSCategory)

- (BOOL)yesterday;
- (BOOL)today;
- (BOOL)thisYear;
- (instancetype)dateWithYMD; /** yyyy-MM-dd */
+ (NSString *)yearMontDayType:(NSDateTimerFormat)format;

- (NSDateComponents *)daltaWithHow;

+ (NSString *)formatTimeWithNumber:(NSNumber *)number;


@end
