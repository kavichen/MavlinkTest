//
//  KCMavlinkHeartBeat.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkHeartBeat.h"

@implementation KCMavlinkHeartBeat
@synthesize mavID = _mavID;
@synthesize customMode = _customMode;
@synthesize type = _type;
@synthesize autopilot = _autopilot;
@synthesize baseMode = _baseMode;
@synthesize systemStatus = _systemStatus;
@synthesize mavlinkVersion = _mavlinkVersion;

- (KCMavlinkHeartBeat *)initWith:(mavlink_message_t *)msg
{
    self = [super init];
    mavlink_heartbeat_t heartbeat;
    mavlink_msg_heartbeat_decode(msg, &heartbeat);
    self.mavID = [NSNumber numberWithInt:0];
    self.customMode = [NSNumber numberWithUnsignedInt:heartbeat.custom_mode];
    self.type = [NSNumber numberWithUnsignedChar:heartbeat.type];
    self.autopilot = [NSNumber numberWithUnsignedChar:heartbeat.autopilot];
    self.baseMode = [NSNumber numberWithUnsignedChar:heartbeat.base_mode];
    self.systemStatus = [NSNumber numberWithUnsignedChar:heartbeat.system_status];
    self.mavlinkVersion = [NSNumber numberWithUnsignedChar:heartbeat.mavlink_version];
    return self;
}
@end
