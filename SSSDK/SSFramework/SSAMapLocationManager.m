//
//  SSAMapLocationManager.m
//  ChiZhaZaiXianiOS
//
//  Created by iMac 3 on 2017/7/20.
//  Copyright © 2017年 深圳三竔有限责任公司 www.sanshengit.com  admin@sansehngit.com. All rights reserved.
//

#import "SSAMapLocationManager.h"

@interface SSAMapLocationManager ()<AMapLocationManagerDelegate>



@end

@implementation SSAMapLocationManager

+ (instancetype)standardUserDefaults
{
    static SSAMapLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
        manager.isContinuity = YES;
    });
    return manager;
}

#pragma mark - 持续定位
- (void)updateingLocation
{
    //高德定位SDK
    [AMapServices sharedServices].apiKey = APPKEY_AMAP;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = [SSAMapLocationManager standardUserDefaults];
    [self.locationManager startUpdatingLocation];
    //开启持续定位
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}


#pragma mark - 高德地图 <AMapLocationManagerDelegate>
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    //    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
        //保存用户当前地置
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@{@"latitude":@(location.coordinate.latitude),@"longitude":@(location.coordinate.longitude)} forKey:@"CZOLUserLocation"];
    
    if (!self.isContinuity) {
        [self configLocationManager];
    }
    
}

- (void)setIsContinuity:(BOOL)isContinuity
{
    if (isContinuity) {
        [self updateingLocation];
    } else {
        [self configLocationManager];
    }
}


#pragma mark - 逆地理编码
- (void)configLocationManager
{
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
    }
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    [self.locationManager setLocationTimeout:6];
    
    [self.locationManager setReGeocodeTimeout:3];
}

- (void)locateAction
{
    //带逆地理的单次定位
    __weak typeof(self) weakSelf = self;
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        //定位信息
//        NSLog(@"location:%@", location.timestamp);

        if ([[NSString stringWithFormat:@"%@",location] componentsSeparatedByString:@"@"][1]) {
            
            weakSelf.date = [[NSString stringWithFormat:@"%@",location] componentsSeparatedByString:@"@"][1];
            
            NSLog(@"%@",[[NSString stringWithFormat:@"%@",location] componentsSeparatedByString:@"@"][1]);
        }
        
        //逆地理信息
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            NSString *address = [NSString stringWithFormat:@"%@%@",regeocode.country,regeocode.formattedAddress];
            [weakSelf formattedAddress:address
                           country:regeocode.country
                          province:regeocode.province
                              city:regeocode.city
                          district:regeocode.district
                          citycode:regeocode.citycode
                            street:regeocode.street
                            number:regeocode.number
                           POIName:regeocode.POIName
                           AOIName:regeocode.AOIName
                            adcode:regeocode.adcode];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:address forKey:CZOLUserFormattedAddress];
            
            [weakSelf updateingLocation];
        }
    }];
}

- (void)formattedAddress:(NSString *)formattedAddress
                 country:(NSString *)country
                province:(NSString *)province
                    city:(NSString *)city
                district:(NSString *)district
                citycode:(NSString *)citycode
                  street:(NSString *)street
                  number:(NSString *)number
                 POIName:(NSString *)POIName
                 AOIName:(NSString *)AOIName
                  adcode:(NSString *)adcode
{
    self.address    = formattedAddress;
    self.country    = country;
    self.province   = province;
    self.city       = city;
    self.district   = district;
    self.citycode   = citycode;
    self.street     = street;
    self.number     = number;
    self.POIName    = POIName;
    self.AOIName    = AOIName;
    self.adcode     = adcode;
}



@end
