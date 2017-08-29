//
//  SSBluetoothCenter.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSBluetoothCenter.h"
#import "SSFramework.h"

@interface SSBluetoothCenter () <CBCentralManagerDelegate,CBPeripheralDelegate>//必须遵循的蓝牙代理
{
    CBCentralManager *manager;
    
    //读服务
    CBService               *ReceiveDataService;
    //读特征
    CBCharacteristic        *Receive20BytesDataCharateristic;
    //写服务
    CBService               *SendDataService;
    //写特征
    CBCharacteristic        *Send20BytesDataCharateristic;
}

@end
@implementation SSBluetoothCenter

+ (instancetype)sharedManager {
    return [super creationShare];
}

#pragma mark ---开始搜索蓝牙
- (void)startSetUUID:(NSArray *)arrayUUID EqualToString:(NSString *)string {
    
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    self.arrayUUID = arrayUUID;
    
    self.equalToString = string;
    
}

#pragma mark ---停止搜索蓝牙
- (void)stop {
    
    [manager stopScan];
    
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
            
        case CBCentralManagerStateUnknown:
        {
            SSLog(@"未知状态");
            
            self.statetypeStr = @"蓝牙错误。无法使用";
        }
            break;
            
        case CBCentralManagerStateUnsupported:
        {
            SSLog(@"模拟器不支持蓝牙调试");
            
            self.statetypeStr = @"模拟器不支持蓝牙调试";
        }
            break;
            
        case CBCentralManagerStateUnauthorized:
            
            break;
            
        case CBCentralManagerStatePoweredOff:
            
            SSLog(@"蓝牙处于关闭状态");
            
            self.statetypeStr = @"蓝牙处于关闭状态";
            
            break;
            
        case CBCentralManagerStateResetting:
            
            break;
            
        case CBCentralManagerStatePoweredOn:
            SSLog(@"蓝牙已开启");
            
            self.statetypeStr = @"蓝牙已开启";
            
            //NO表示不会重复搜索以搜索到到设备
            NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
            
            //开始搜索蓝牙
            [manager scanForPeripheralsWithServices:nil options:options];
            
            break;
    }
}

- (void) setStateStr {
    
    if (self.stateStr) {
        
        self.stateStr(self.statetypeStr);
        
    }
}

#pragma mark ---获取当前蓝牙状态/所有的设备
- (void) GetStateStr:(stateStr)stateStr newBlueTooths:(newBlueTooths)newBlueTooths {
    
    self.stateStr = ^(NSString *str) {
        
        stateStr(str);
        
    };
    
    self.newBlueTooths = ^(NSMutableDictionary *dictM) {
        
        newBlueTooths(dictM);
        
    };
    
}

- (void)GetconnectOK:(connectOK)connectOK error:(error)error peripheralDiscover:(peripheralDiscover)peripheralDiscover allMessage:(allMessage)allMessage {
    
    self.connectOK = ^(CBCentralManager *connectOKManager, CBPeripheral *connectOKPeripheral) {
        
        connectOK(connectOKManager, connectOKPeripheral);
        
    };
    
    self.error = ^(NSError *errors) {
        
        error(errors);
        
    };
    
    self.peripheralDiscover = ^(CBPeripheral *perDis) {
        
        peripheralDiscover(perDis);
        
    };
    
    self.allMessage = ^(CBPeripheral *allMessagePeripheral, CBService *allMessageService) {
        
        allMessage(allMessagePeripheral, allMessageService);
        
    };
    
}

#pragma mark ---搜索到蓝牙
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    if ([peripheral.name isEqualToString:self.equalToString]) {
        
        [dictM setObject:peripheral forKey:peripheral.name];
        
        SSLog(@"peripheral.name＝＝＝%@",peripheral.name);
        
        if (self.newBlueTooths) {
            
            self.newBlueTooths(dictM);
            
        }
        
    }else if(!self.equalToString) {
        
        
        [dictM setObject:peripheral.name forKey:peripheral.name];
        
        SSLog(@"peripheral.name＝＝＝%@",peripheral.name);
        
        if (self.newBlueTooths) {
            
            self.newBlueTooths(dictM);
            
        }
        
    }
    
}

#pragma mark ---连接蓝牙
- (void)ConnectPeripheral:(CBPeripheral *)connectPeripheral {
    
    if (connectPeripheral.name) {
        
        [manager connectPeripheral:connectPeripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
        
    }
}

#pragma mark ---连接成功的回调
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    peripheral.delegate = self;
    
    //查找服务
    [peripheral discoverServices:nil];
    
    if (self.connectOK) {
        
        self.connectOK(central, peripheral);
    }
    
}



#pragma mark ---连接失败的回调
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
    if (self.error) {
        
        self.error(error);
        
    }
    
    SSLog(@"连接失败%@",error);
    
}

#pragma mark ---扫描服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error  {
    
    SSLog(@"%@",peripheral);
    
    if (self.peripheralDiscover) {
        
        self.peripheralDiscover(peripheral);
        
    }
    
    for (CBService *services in peripheral.services)
    {
        
        if ([[services UUID] isEqual:[CBUUID UUIDWithString:self.arrayUUID[0]]]) {
            
            ReceiveDataService = services;
            
            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:self.arrayUUID[1]],[CBUUID UUIDWithString:self.arrayUUID[3]]] forService:ReceiveDataService];
        }
        
        else if ([[services UUID] isEqual:[CBUUID UUIDWithString:self.arrayUUID[2]]])
        {
            SendDataService = services;
            
            
            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:self.arrayUUID[1]],[CBUUID UUIDWithString:self.arrayUUID[3]]] forService:SendDataService];
        }
        
        
    }
    
}

#pragma mark ---从服务中扫描特征值
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    
    if (self.allMessage) {
        
        self.allMessage(peripheral, service);
        
    }
    // 新建特征值数组
    NSArray *characteristics = [service characteristics];
    SSLog(@"characteristics=%@",characteristics);
    CBCharacteristic *characteristic;
    
    
    
    if ([[service UUID] isEqual:[CBUUID UUIDWithString:self.arrayUUID[0]]])
    {
        for (characteristic in characteristics)
        {
            SSLog(@"发现特值UUID: %@\n", [characteristic UUID].data);
            if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:self.arrayUUID[3]]])
            {
                Send20BytesDataCharateristic = characteristic;
                
            }
            else if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:self.arrayUUID[1]]])
            {
                Receive20BytesDataCharateristic = characteristic;
                
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                
            }
        }
    }
    
    SSLog(@"%s\n连接%@设备成功\n\
          Services==%lu\n\
          发现服务UUID:\n\
          service.UUID.data==%@\n\
          service.UUID==%@\n\
          identifier==%@\n\
          name==%@\n\
          state==%ld,",
          __func__,
          peripheral.name,
          peripheral.services.count,
          service.UUID.data,
          service.UUID,
          service.peripheral.identifier,
          service.peripheral.name,
          (long)service.peripheral.state);
    
}


#pragma mark ---发送数据
- (void)WriteTo:(CBPeripheral *)peripheral Value:(NSData *)data {
    
    [peripheral writeValue:data forCharacteristic:Send20BytesDataCharateristic type:CBCharacteristicWriteWithoutResponse];
    
    
}

#pragma mark ---数据发送后的回调
- (void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    SSLog(@"Did write characteristic value : %@ with ID %@", characteristic.value, characteristic.UUID);
    
    SSLog(@"With error: %@", error);
    
}

#pragma mark ---断开连接时代回调
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
    SSLog(@"连接错误");
    
    if (self.error) {
        
        self.error(error);
        
    }
    
}


@end
