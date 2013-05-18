//
//  KCMavlinkRawIMU.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkRawIMU.h"

@implementation KCMavlinkRawIMU
@synthesize mavID = _mavID;
@synthesize timeUsec = _timeUsec;
@synthesize xAcc = _xAcc;
@synthesize yAcc = _yAcc;
@synthesize zAcc = _zAcc;
@synthesize xGyro = _xGyro;
@synthesize yGyro = _yGyro;
@synthesize zGyro = _zGyro;
@synthesize xMag = _xMag;
@synthesize yMag = _yMag;
@synthesize zMag = _zMag;

- (KCMavlinkRawIMU *)initWith:(mavlink_message_t *)msg
{
    mavlink_raw_imu_t raw_imu;
    mavlink_msg_raw_imu_decode(msg, &raw_imu);
    self.mavID = [NSNumber numberWithInt:27];
    self.timeUsec = [NSNumber numberWithUnsignedLongLong:raw_imu.time_usec];
    self.xAcc = [NSNumber numberWithShort:raw_imu.xacc];
    self.yAcc = [NSNumber numberWithShort:raw_imu.yacc];
    self.zAcc = [NSNumber numberWithShort:raw_imu.zacc];
    self.xGyro = [NSNumber numberWithShort:raw_imu.xgyro];
    self.yGyro = [NSNumber numberWithShort:raw_imu.ygyro];
    self.zGyro = [NSNumber numberWithShort:raw_imu.zgyro];
    self.xMag = [NSNumber numberWithShort:raw_imu.xmag];
    self.yMag = [NSNumber numberWithShort:raw_imu.ymag];
    self.zMag = [NSNumber numberWithShort:raw_imu.zmag];
    return self;
}
@end
