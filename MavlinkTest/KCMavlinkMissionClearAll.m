//
//  KCMavlinkMissionClearAll.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkMissionClearAll.h"

@implementation KCMavlinkMissionClearAll
@synthesize mavID = _mavID;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;

- (KCMavlinkMissionClearAll *)initWith:(mavlink_message_t *)msg
{
    mavlink_mission_clear_all_t mission_clear_all;
    mavlink_msg_mission_clear_all_decode(msg, &mission_clear_all);
    self.mavID = [NSNumber numberWithInt:45];
    self.targetSystem = [NSNumber numberWithUnsignedChar:mission_clear_all.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:mission_clear_all.target_component];
    return self; 
}

@end
