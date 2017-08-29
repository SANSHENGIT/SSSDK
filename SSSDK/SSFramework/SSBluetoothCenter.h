//
//  SSBluetoothCenter.h
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SSManager.h"

/**
 *  当前蓝牙状态
 *
 *  @param NSString
 */
typedef void(^stateStr)(NSString *stateStr);

/**
 *  扫描到的蓝牙
 *
 *  @param NSMutableArray
 */
typedef void(^newBlueTooths)(NSMutableDictionary *newBlueTooths);

/**
 *  连接成功后的信息
 *
 *  @param CBCentralManager
 */
typedef void(^connectOK)(CBCentralManager *connectOKManager, CBPeripheral *connectOKPeripheral);


/**
 *  连接失败的错误信息
 *
 *  @param NSError
 */
typedef void(^error)(NSError *error);

/**
 *  扫描服务
 *
 *  @param CBPeripheral
 */
typedef void(^peripheralDiscover)(CBPeripheral *peripheralDiscover);

/**
 *  从服务中扫描特征值
 */
typedef void(^allMessage)(CBPeripheral *allMessagePeripheral, CBService *allMessageService);


@interface SSBluetoothCenter : SSManager

@property (nonatomic, strong) NSArray *arrayUUID;

@property (nonatomic, copy) NSString *statetypeStr;

@property (nonatomic, copy) stateStr stateStr;

@property (nonatomic, copy) newBlueTooths newBlueTooths;

@property (nonatomic, copy) connectOK connectOK;

@property (nonatomic, copy) error error;

@property (nonatomic, copy) peripheralDiscover peripheralDiscover;

@property (nonatomic, copy) allMessage allMessage;

@property (nonatomic, copy) NSString *equalToString;


/**
 *  创建中心服务器
 */
+ (instancetype)sharedManager;

/**
 *  开始搜索蓝牙
 *
 *  @param UUIDs 读服务／写服务／读特征／写特征
 *  @param string    按蓝牙名称搜索
 */
- (void)startSetUUIDs:(NSArray *)UUIDs EqualToString:(NSString *)string;

/**
 *  停止搜索蓝牙
 */
- (void)stop;

/**
 *  获取蓝牙当前状态
 *
 *  @param stateStr      当前蓝牙状态回调
 *  @param newBlueTooths 扫描到的蓝牙数组回调
 */
- (void)GetStateStr:(stateStr)stateStr newBlueTooths:(newBlueTooths)newBlueTooths;

/**
 *  连接蓝牙时的所有信息
 *
 *  @param connectOK          连接成功后的信息
 *  @param error              连接失败的错误信息
 *  @param peripheralDiscover 扫描到的服务
 *  @param allMessage         从服务中扫描特征值
 */
- (void)GetconnectOK:(connectOK)connectOK error:(error)error peripheralDiscover:(peripheralDiscover)peripheralDiscover allMessage:(allMessage)allMessage;


/**
 *  连接蓝牙
 *
 *  @param connectPeripheral 蓝牙设备
 */
- (void)ConnectPeripheral:(CBPeripheral *)connectPeripheral;

/**
 *  写入数据
 *
 *  @param activePeripheral 蓝牙设备
 *  @param data             写入数据
 */
- (void)WriteTo:(CBPeripheral *)activePeripheral Value:(NSData *)data;



@end
