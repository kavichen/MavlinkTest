//
//  KCMavlinkSetMode.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkSetMode.h"

@implementation KCMavlinkSetMode
@synthesize mavID = _mavID;
@synthesize customMode = _customMode;
@synthesize targetSystem = _targetSystem;
@synthesize baseMode = _baseMode;

- (KCMavlinkSetMode *)initWith:(mavlink_message_t *)msg
{
    mavlink_set_mode_t set_mode;
    mavlink_msg_set_mode_decode(msg, &set_mode);
    self.mavID = [NSNumber numberWithInt:11];
    self.customMode = [NSNumber numberWithUnsignedInt:set_mode.custom_mode];
    self.targetSystem = [NSNumber numberWithUnsignedChar:set_mode.target_system];
    self.baseMode = [NSNumber numberWithUnsignedChar:set_mode.base_mode];
    return self;
}
@end
