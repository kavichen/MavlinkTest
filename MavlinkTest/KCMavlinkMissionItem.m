//
//  KCMavlinkMissionItem.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkMissionItem.h"

@implementation KCMavlinkMissionItem
@synthesize mavID = _mavID;
@synthesize param1 = _param1;
@synthesize param2 = _param2;
@synthesize param3 = _param3;
@synthesize param4 = _param4;
@synthesize x  = _x;
@synthesize y = _y;
@synthesize z = _z;
@synthesize seq = _seq;
@synthesize command = _command;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;
@synthesize frame = _frame;
@synthesize current = _current;
@synthesize autoContinue = _autoContinue;

- (KCMavlinkMissionItem *)initWith:(mavlink_message_t *)msg
{
    mavlink_mission_item_t mission_item;
    mavlink_msg_mission_item_decode(msg, &mission_item);
    
    self.mavID = [NSNumber numberWithInt:39];
    self.param1 = [NSNumber numberWithFloat:mission_item.param1];
    self.param2 = [NSNumber numberWithFloat:mission_item.param2];
    self.param3 = [NSNumber numberWithFloat:mission_item.param3];
    self.param4 = [NSNumber numberWithFloat:mission_item.param4];
    
    self.x = [NSNumber numberWithFloat:mission_item.x];
    self.y = [NSNumber numberWithFloat:mission_item.y];
    self.z = [NSNumber numberWithFloat:mission_item.z];
    
    self.seq = [NSNumber numberWithUnsignedShort:mission_item.seq];
    self.command = [NSNumber numberWithUnsignedShort:mission_item.command];
    self.targetSystem = [NSNumber numberWithUnsignedChar:mission_item.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:mission_item.target_component];
    self.frame = [NSNumber numberWithUnsignedChar:mission_item.frame];
    self.current = [NSNumber numberWithUnsignedChar:mission_item.current];
    self.autoContinue = [NSNumber numberWithUnsignedChar:mission_item.autocontinue];
    return self;
}

@end
