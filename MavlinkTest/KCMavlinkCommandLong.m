//
//  KCMavlinkCommandLong.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkCommandLong.h"

@implementation KCMavlinkCommandLong
@synthesize mavID = _mavID;
@synthesize param1 = _param1;
@synthesize param2 = _param2;
@synthesize param3 = _param3;
@synthesize param4 = _param4;
@synthesize param5 = _param5;
@synthesize param6 = _param6;
@synthesize param7 = _param7;
@synthesize command = _command;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;
@synthesize confirmation = _confirmation;

- (KCMavlinkCommandLong *)initWith:(mavlink_message_t *)msg
{
    mavlink_command_long_t command_long;
    mavlink_msg_command_long_decode(msg, &command_long);
    self.mavID = [NSNumber numberWithInt:76];
    self.param1 = [NSNumber numberWithFloat:command_long.param1];
    self.param2 = [NSNumber numberWithFloat:command_long.param2];
    self.param3 = [NSNumber numberWithFloat:command_long.param3];
    self.param4 = [NSNumber numberWithFloat:command_long.param4];
    self.param5 = [NSNumber numberWithFloat:command_long.param5];
    self.param6 = [NSNumber numberWithFloat:command_long.param6];
    self.param7 = [NSNumber numberWithFloat:command_long.param7];
    self.command = [NSNumber numberWithUnsignedShort:command_long.command];
    self.targetSystem = [NSNumber numberWithUnsignedChar:command_long.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:command_long.target_component];
    self.confirmation = [NSNumber numberWithUnsignedChar:command_long.confirmation];
    return self;
}

@end
