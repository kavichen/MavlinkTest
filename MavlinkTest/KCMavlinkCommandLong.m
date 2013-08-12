//
//  KCMavlinkCommandLong.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkCommandLong.h"

@implementation KCMavlinkCommandLong
//@synthesize mavID = _mavID;
//@synthesize param1 = _param1;
//@synthesize param2 = _param2;
//@synthesize param3 = _param3;
//@synthesize param4 = _param4;
//@synthesize param5 = _param5;
//@synthesize param6 = _param6;
//@synthesize param7 = _param7;
//@synthesize command = _command;
//@synthesize targetSystem = _targetSystem;
//@synthesize targetComponent = _targetComponent;
//@synthesize confirmation = _confirmation;
//
//- (KCMavlinkCommandLong *)initWith:(mavlink_message_t *)msg
//{
//    mavlink_command_long_t command_long;
//    mavlink_msg_command_long_decode(msg, &command_long);
//    self.mavID = [NSNumber numberWithInt:76];
//    self.param1 = [NSNumber numberWithFloat:command_long.param1];
//    self.param2 = [NSNumber numberWithFloat:command_long.param2];
//    self.param3 = [NSNumber numberWithFloat:command_long.param3];
//    self.param4 = [NSNumber numberWithFloat:command_long.param4];
//    self.param5 = [NSNumber numberWithFloat:command_long.param5];
//    self.param6 = [NSNumber numberWithFloat:command_long.param6];
//    self.param7 = [NSNumber numberWithFloat:command_long.param7];
//    self.command = [NSNumber numberWithUnsignedShort:command_long.command];
//    self.targetSystem = [NSNumber numberWithUnsignedChar:command_long.target_system];
//    self.targetComponent = [NSNumber numberWithUnsignedChar:command_long.target_component];
//    self.confirmation = [NSNumber numberWithUnsignedChar:command_long.confirmation];
//    return self;
//}
//- (KCMavlinkCommandLong *)init
//{
//    self = [super init];
//    return self;
//}
- (void)packCommandLongMsg:(KCMavlinkIO *)mavlinkIO
                fromSystemID:(NSNumber *)sysID
           fromComponentID:(NSNumber *)compID
                   Command:(NSNumber *)com
              Confirmation:(NSNumber *)Con
                    Param1:(float)p1
                    Param2:(float)p2
                    Param3:(float)p3
                    Param4:(float)p4
                    Param5:(float)p5
                    Param6:(float)p6
                    Param7:(float)p7
               intoMessage:(mavlink_message_t *)message
{
    mavlink_message_t *msg = message;
    printf("message = %o\n",message);
    printf("local msg = %o\n",msg);
    uint8_t system_id = [sysID unsignedCharValue];
    uint8_t component_id = [compID unsignedCharValue];
    uint8_t target_system  = [mavlinkIO.sysid unsignedCharValue];
    uint8_t target_component = [mavlinkIO.compid unsignedCharValue];
    uint16_t command = [com unsignedShortValue];
    uint8_t confirmation = [Con unsignedCharValue];
//    float p1float = [p1 floatValue];
//    float p2float = [p2 floatValue];
//    float p3float = [p3 floatValue];
//    float p4float = [p4 floatValue];
//    float p5float = [p5 floatValue];
//    float p6float = [p6 floatValue];
//    float p7float = [p7 floatValue];
    mavlink_msg_command_long_pack(system_id, component_id, msg, target_system, target_component, command, confirmation, p1, p2, p3, p4, p5, p6, p7);
}


@end
