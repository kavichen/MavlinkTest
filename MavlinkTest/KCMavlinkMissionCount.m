//
//  KCMavlinkMissionCount.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkMissionCount.h"

@implementation KCMavlinkMissionCount
@synthesize mavID = _mavID;
@synthesize count = _count;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;

- (KCMavlinkMissionCount *)initWith:(mavlink_message_t *)msg
{
    mavlink_mission_count_t mission_count;
    mavlink_msg_mission_count_decode(msg, &mission_count);
    self.mavID = [NSNumber numberWithInt:44];
    self.count = [NSNumber numberWithUnsignedShort:mission_count.count];
    self.targetSystem = [NSNumber numberWithUnsignedChar:mission_count.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:mission_count.target_component];
    return self;
}

@end
