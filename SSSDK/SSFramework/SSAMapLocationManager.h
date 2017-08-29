//
//  SSAMapLocationManager.h
//  ChiZhaZaiXianiOS
//
//  Created by iMac 3 on 2017/7/20.
//  Copyright © 2017年 深圳三竔有限责任公司 www.sanshengit.com  admin@sansehngit.com. All rights reserved.
//
// 地图位置管理器
// pod "AMapLocation", :inhibit_warnings => true


#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


//高德AppKey
static NSString *const APPKEY_AMAP = @"4eae3de4fa49a5f645700e2ea03d80f4";

//NSUserDefaults 用户当前地址
static NSString *const CZOLUserFormattedAddress = @"CZOLUserFormattedAddress";

@interface SSAMapLocationManager : NSObject

@property (nonatomic, strong) AMapLocationManager *locationManager;

//国家
@property (nonatomic, copy) NSString *country;
//洲/省/直辖市
@property (nonatomic, copy) NSString *province;
//市
@property (nonatomic, copy) NSString *city;
//区
@property (nonatomic, copy) NSString *district;
//街道
@property (nonatomic, copy) NSString *street;
//门牌号
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *POIName;
@property (nonatomic, copy) NSString *AOIName;
//电话区号
@property (nonatomic, copy) NSString *citycode;
//时间 (2017/7/20 中国标准时间 01:57:23)
@property (nonatomic, copy) NSString *date;
//国家省市区街道小区(大厦)
@property (nonatomic, copy) NSString *address;
//广告编码
@property (nonatomic, copy) NSString *adcode;
//是否可持续性定位(默认YES ,NO:保存对象属性)
@property (nonatomic, assign) BOOL isContinuity;

+ (instancetype)standardUserDefaults;

#pragma mark - 持续定位
- (void)updateingLocation;

#pragma mark - 逆地理编码
- (void)configLocationManager;

- (void)locateAction;



@end
