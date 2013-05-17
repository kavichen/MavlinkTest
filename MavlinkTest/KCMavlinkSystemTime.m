//
//  KCMavlinkSystemTime.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkSystemTime.h"

@implementation KCMavlinkSystemTime
@synthesize mavID = _mavID;
@synthesize timeUnixUsec  = _timeUnixUsec;
@synthesize timeBootMS = _timeBootMS;

- (KCMavlinkSystemTime *)initWith:(mavlink_message_t *)msg
{
    mavlink_system_time_t system_time;
    mavlink_msg_system_time_decode(msg, &system_time);
    self.mavID = [NSNumber numberWithInt:2];
    self.timeUnixUsec = [NSNumber numberWithUnsignedLongLong:system_time.time_unix_usec];
    self.timeBootMS = [NSNumber numberWithUnsignedInt:system_time.time_boot_ms];
    return self;
}
@end
