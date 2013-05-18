//
//  KCMavlinkMissionACK.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkMissionACK.h"

@implementation KCMavlinkMissionACK
@synthesize mavID = _mavID;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;
@synthesize type = _type;

- (KCMavlinkMissionACK *)initWith:(mavlink_message_t *)msg
{
    mavlink_mission_ack_t mission_ack;
    mavlink_msg_mission_ack_decode(msg, &mission_ack);
    self.mavID = [NSNumber numberWithInt:47];
    self.targetSystem = [NSNumber numberWithUnsignedChar:mission_ack.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:mission_ack.target_component];
    self.type = [NSNumber numberWithUnsignedChar:mission_ack.type];
    return self;
}

@end
