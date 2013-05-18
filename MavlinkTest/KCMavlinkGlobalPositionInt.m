//
//  KCMavlinkGlobalPositionInt.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkGlobalPositionInt.h"

@implementation KCMavlinkGlobalPositionInt
@synthesize mavID = _mavID;
@synthesize timeBootMS = _timeBootMS;
@synthesize lat = _lat;
@synthesize lon = _lon;
@synthesize alt = _alt;
@synthesize relativeAlt = _relativeAlt;
@synthesize vx = _vx;
@synthesize vy = _vy;
@synthesize vz = _vz;
@synthesize hdg = _hdg;

- (KCMavlinkGlobalPositionInt *)initWith:(mavlink_message_t *)msg
{
    mavlink_global_position_int_t global_position_int;
    mavlink_msg_global_position_int_decode(msg, &global_position_int);
    self.mavID = [NSNumber numberWithInt:33];
    self.timeBootMS = [NSNumber numberWithUnsignedInt:global_position_int.time_boot_ms];
    self.lat = [NSNumber numberWithInt:global_position_int.lat];
    self.lon = [NSNumber numberWithInt:global_position_int.lon];
    self.alt = [NSNumber numberWithInt:global_position_int.alt];
    self.relativeAlt = [NSNumber numberWithInt:global_position_int.relative_alt];
    self.vx = [NSNumber numberWithShort:global_position_int.vx];
    self.vy = [NSNumber numberWithShort:global_position_int.vy];
    self.vz = [NSNumber numberWithShort:global_position_int.vz];
    self.hdg = [NSNumber numberWithUnsignedShort:global_position_int.hdg];
    return self;
}
@end
