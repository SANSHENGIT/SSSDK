//
//  SSDevice.h
//  ChiZhaZaiXianiOS
//
//  Created by iMac 3 on 2017/7/18.
//  Copyright © 2017年 深圳三竔有限责任公司 www.sanshengit.com  admin@sansehngit.com. All rights reserved.
//
/*
 版权:深圳市三竔科技有限责任公司所有
 联系电话:0755-83349101
 官网:www.sanshengit.com
 */

#import <Foundation/Foundation.h>
#import "SSCommonlyMacro.h"

@interface SSDevice : NSObject
// 单例
+ (instancetype)sharedManager;

/** 能否打电话 */
@property (nonatomic, assign, readonly) BOOL canMakePhoneCall NS_EXTENSION_UNAVAILABLE_IOS("");

//iPhone名称
@property (nonatomic, copy, readonly) NSString *iPhoneName;
//App版本号(如:1.0)
@property (nonatomic, copy, readonly) NSString *appVersion;
//电池电量
@property (nonatomic, assign, readonly) float batteryLevel;
//内部型号
@property (nonatomic, copy, readonly) NSString *localizedModel;
//系统名称
@property (nonatomic, copy, readonly) NSString *systemName;
//系统版本(如:10.2.1)
@property (nonatomic, copy, readonly) NSString *systemVersion;
//唯一识别码UUID(如:1E431DED-8419-45B4-A3DE-BAB5492B46E1)
@property (nonatomic, copy, readonly) NSString *UUID;

#pragma mark - Device
//设备型号(如:iPhone 6s Plus)
@property (nonatomic, copy, readonly) NSString *deviceName;
//deveice model
@property (nonatomic, copy, readonly) NSString *deviceModel;
//mac地址
@property (nonatomic, copy, readonly) NSString *macAddress;
//设备IP(如:10.154.221.94 / 192.168.0.106)
@property (nonatomic, copy, readonly) NSString *deviceIP;
//WIFI地址
@property (nonatomic, copy, readonly) NSString *WiFiAddress;
//广告位标识符idfa
@property (nonatomic, copy, readonly) NSString *idfa;
//设备上次启动时间(需要服务器记录)
@property (nonatomic, copy, readonly) NSString *systemUptime;
//设备当前启动时间(需要传给服务器)
@property (nonatomic, copy, readonly) NSString *launchTime;
//年
@property (nonatomic, copy) NSString *year;
//月
@property (nonatomic, copy) NSString *month;
//日
@property (nonatomic, copy) NSString *day;
//时
@property (nonatomic, copy) NSString *hour;
//分
@property (nonatomic, copy) NSString *minute;
//秒
@property (nonatomic, copy) NSString *second;
//星期几
@property (nonatomic, copy) NSString *weekday;



#pragma mark - CPU
//CPU数量
@property (nonatomic, assign, readonly) NSInteger CPUCount;
//CPU使用率
@property (nonatomic, assign, readonly) float CPUUsage;
//单个CPU使用率
@property (nonatomic, strong, readonly) NSArray *perCPUUsage;

#pragma mark - Disk
//磁盘总量
@property (nonatomic, assign, readonly) int64_t totalDiskSpace;
//磁盘未使用空间
@property (nonatomic, assign, readonly) int64_t freeDiskSpace;
//已使用的磁盘空间
@property (nonatomic, assign, readonly) int64_t usedDiskSpace;

#pragma mark - Memory
//内存总量
@property (nonatomic, assign, readonly) int64_t totalMemory;
//活跃的内存空间
@property (nonatomic, assign, readonly) int64_t activeMemory;
//不活跃的内存空间
@property (nonatomic, assign, readonly) int64_t inActiveMemory;
//空闲的内存空间
@property (nonatomic, assign, readonly) int64_t freeMemory;
//正在使用的内存空间
@property (nonatomic, assign, readonly) int64_t usedMemory;
//存放内核的内存空间
@property (nonatomic, assign, readonly) int64_t wiredMemory;
//可释放的内存空间
@property (nonatomic, assign, readonly) int64_t purgableMemory;


@end






