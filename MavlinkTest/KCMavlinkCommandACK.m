//
//  KCMavlinkCommandACK.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkCommandACK.h"

@implementation KCMavlinkCommandACK
@synthesize mavID = _mavID;
@synthesize command = _command;
@synthesize result = _result;

- (KCMavlinkCommandACK *)initWith:(mavlink_message_t *)msg
{
    mavlink_command_ack_t command_ack;
    mavlink_msg_command_ack_decode(msg, &command_ack);
    self.mavID = [NSNumber numberWithInt:77];
    self.command = [NSNumber numberWithUnsignedShort:command_ack.command];
    self.result = [NSNumber numberWithUnsignedChar:command_ack.result];
    return self;
}

@end
