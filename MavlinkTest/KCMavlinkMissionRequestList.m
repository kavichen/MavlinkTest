//
//  KCMavlinkMissionRequestList.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkMissionRequestList.h"

@implementation KCMavlinkMissionRequestList
@synthesize mavID = _mavID;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;

- (KCMavlinkMissionRequestList *)initWith:(mavlink_message_t *)msg
{
    mavlink_mission_request_list_t mission_request_list;
    mavlink_msg_mission_request_list_decode(msg, &mission_request_list);
    self.mavID = [NSNumber numberWithInt:43];
    self.targetSystem = [NSNumber numberWithUnsignedChar:mission_request_list.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:mission_request_list.target_component];
    return self;
}

@end
