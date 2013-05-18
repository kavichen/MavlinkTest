//
//  KCMavlinkAttitude.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkAttitude.h"

@implementation KCMavlinkAttitude
@synthesize mavID = _mavID;
@synthesize timeBootMS = _timeBootMS;
@synthesize roll = _roll;
@synthesize pitch = _pitch;
@synthesize yaw = _yaw;
@synthesize rollSpeed = _rollSpeed;
@synthesize pitchSpeed = _pitchSpeed;
@synthesize yawSpeed = _yawSpeed;

- (KCMavlinkAttitude *)initWith:(mavlink_message_t *)msg
{
    mavlink_attitude_t attitude;
    mavlink_msg_attitude_decode(msg, &attitude);
    
    self.mavID = [NSNumber numberWithInt:30];
    self.timeBootMS = [NSNumber numberWithUnsignedInt:attitude.time_boot_ms];
    self.roll = [NSNumber numberWithFloat:attitude.roll];
    self.pitch = [NSNumber numberWithFloat:attitude.pitch];
    self.yaw = [NSNumber numberWithFloat:attitude.yaw];
    self.rollSpeed = [NSNumber numberWithFloat:attitude.rollspeed];
    self.pitchSpeed = [NSNumber numberWithFloat:attitude.pitchspeed];
    self.yawSpeed = [NSNumber numberWithFloat:attitude.yawspeed];
    return self;
}
@end
