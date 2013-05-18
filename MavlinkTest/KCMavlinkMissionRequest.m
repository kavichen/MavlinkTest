//
//  KCMavlinkMissionRequest.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkMissionRequest.h"

@implementation KCMavlinkMissionRequest
@synthesize mavID = _mavID;
@synthesize seq = _seq;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;

- (KCMavlinkMissionRequest *)initWith:(mavlink_message_t *)msg
{
    mavlink_mission_request_t mission_request;
    mavlink_msg_mission_request_decode(msg, &mission_request);
    self.mavID = [NSNumber numberWithInt:40];
    self.seq = [NSNumber numberWithUnsignedShort:mission_request.seq];
    self.targetSystem = [NSNumber numberWithUnsignedChar:mission_request.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:mission_request.target_component];
    return self;
}

@end
