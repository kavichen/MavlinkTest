//
//  KCSokcet.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-6.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCSokcet.h"
#import "mavlink.h"
#define LOCAL_PORT 14550
#define SERVER_PORT 14550

@interface KCSokcet()

@end

@implementation KCSokcet
//@synthesize clientAddress = _clientAddress;

#pragma mark - getter and setter

//
//- (NSString *)clientAddress
//{
//    if (!_clientAddress) {
//        _clientAddress = [NSString string];
//    }
//    return _clientAddress;
//}

#pragma mark - init class

- (KCSokcet *)init
{
    self = [super init];
    return self;
}

- (BOOL)bindToLocal
{
    BOOL isSuccess = 0;
    NSError *error = nil;
    if ([self bindToPort:LOCAL_PORT error:&error]) {
        isSuccess = 1;
    }else{
        
        NSLog(@"bind to server has an error: %@",error);
    }
    return isSuccess;
}

- (BOOL)bindToServer
{
    BOOL isSuccess = 0;
    NSError *error = nil;
    if ([self bindToPort:SERVER_PORT error:&error]) {
        isSuccess = 1;
    }else{
        NSLog(@"bind to client has an error: %@",error);
    }
    return isSuccess;
}

- (BOOL)beginReceiving
{
    __block NSError *errPtr = nil;
    __block BOOL result = [super beginReceiving:&errPtr];
    if (errPtr) {
        NSLog(@"beginReceiving has an error:%@",errPtr);
    }
    return result;
}

//- (void)receiveDataFromCilent:(KCSokcet *)socket
//{
//    NSData *rawData = [[NSData alloc] init];
//    NSData *addressData = [[NSData alloc] init];
//    id filterContext;
//    [self udpSocket:socket didReceiveData:rawData
//        fromAddress:addressData
//  withFilterContext:filterContext];
//    
//}

//- (void)udpSocket:(GCDAsyncUdpSocket *)socket
//   didReceiveData:(NSData *)data
//      fromAddress:(NSData *)address
//withFilterContext:(id)filterContext
//{
//    self.rawData = data;
//    [self processRawData];
//    
//}



//- (void)processRawDataFromClient
//{
//    mavlink_message_t msg;
//    mavlink_status_t status;
//    mavlink_sys_status_t sys_status;
//    mavlink_local_position_ned_t local_position_ned;
//    mavlink_attitude_t attitude;
//    mavlink_global_position_int_t global_position_int_t;
//    
//    Byte *buf = (Byte *)[self.rawData bytes];
//    NSInteger rawDataLength = [self.rawData length];
//    
//    unsigned int temp = 0;
//    for (int i = 0; i < rawDataLength; ++i) {
//        int parseSuccess;
//        parseSuccess = mavlink_parse_char(MAVLINK_COMM_0, buf[i], &msg, &status);
//        temp = buf[i];
//        if (parseSuccess) {
//            switch (msg.msgid){
//                case 0:
//                    
//                    NSLog(@" ***********Heart_Beat************");
//                    NSLog(@"*       msg.msgid = %3d           *\n",msg.msgid);
//                    NSLog(@"*       msg.seq = %3d             *\n",msg.seq);
//                    NSLog(@"*       msg.compid = %3d          *\n",msg.sysid);
//                    NSLog(@" *********************************\n");
//                    break;
//                    
//                    
//                case 1:
//                    mavlink_msg_sys_status_decode(&msg,&sys_status);
//                    NSLog(@" *********System_Status***********\n");
//                    NSLog(@"*       battery voltage = %5d   *\n",sys_status.voltage_battery);
//                    NSLog(@"*       battery current = %3d     *\n",sys_status.current_battery);
//                    NSLog(@"*       battery remaining = %3d   *\n",sys_status.battery_remaining);
//                    NSLog(@" *********************************\n");
//                    break;
//                    
//                case 32:
//                    mavlink_msg_local_position_ned_decode(&msg,&local_position_ned);
//                    
//                    NSLog(@" *********Local_Position**********\n");
//                    NSLog(@"*       X Position = %3f          *\n",local_position_ned.x);
//                    NSLog(@"*       Y Position = %3f          *\n",local_position_ned.y);
//                    NSLog(@"*       Z Position = %3f          *\n",local_position_ned.z);
//                    NSLog(@" *********************************\n");
//                    break;
//                    
//                case 30:
//                    mavlink_msg_attitude_decode(&msg, &attitude);
//                    NSLog(@" *********Attitude****************\n");
//                    NSLog(@"*       roll = %3f                *\n",attitude.roll);
//                    NSLog(@"*       pitch = %3f               *\n",attitude.pitch);
//                    NSLog(@"*       yaw = %3f                 *\n",attitude.yaw);
//                    NSLog(@" *********************************\n");
//                    break;
//                    
//                case 33:
//                    mavlink_msg_global_position_int_decode(&msg,&global_position_int_t);
//                    
//                    NSLog(@" *********Global_Position_Int******\n");
//                    NSLog(@"*       time_boot_ms = %d           *\n",global_position_int_t.time_boot_ms);
//                    NSLog(@"*       lat = %4d                   *\n",global_position_int_t.lat);
//                    NSLog(@"*       lon = %4d                   *\n",global_position_int_t.lon);
//                    NSLog(@"*       alt = %4d                   *\n",global_position_int_t.alt);
//                    NSLog(@"*       hdg = %4d                   *\n",global_position_int_t.hdg);
//                    NSLog(@" *********************************\n");
//                    break;
//                    // case 34:
//                    /*
//                     *mavlink_msg_global_position_int_decode();
//                     */
//                    
//                    
//                default:
//                    NSLog(@"\n");
//                    continue;
//                    
//            }
//        }
//    }
//}

@end
