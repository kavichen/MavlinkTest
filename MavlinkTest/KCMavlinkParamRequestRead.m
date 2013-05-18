//
//  KCMavlinkParamRequestRead.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkParamRequestRead.h"

@implementation KCMavlinkParamRequestRead
@synthesize mavID = _mavID;
@synthesize paraIndex = _paraIndex;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;
@synthesize paramID = _paraID;


- (KCMavlinkParamRequestRead *)initWith:(mavlink_message_t *)msg
{
    mavlink_param_request_read_t para_request_read;
    mavlink_msg_param_request_read_decode(msg, &para_request_read);
    NSNumber *temp = [[NSNumber alloc] init];
    self.mavID = [NSNumber numberWithInt:20];
    self.paraIndex = [NSNumber numberWithShort:para_request_read.param_index];
    self.targetSystem = [NSNumber numberWithUnsignedChar:para_request_read.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:para_request_read.target_component];
    self.paramID = [NSMutableArray arrayWithCapacity:16];
    for (int i = 0; i < 16; ++i) {
        temp = [NSNumber numberWithChar:para_request_read.param_id[i]];
        [self.paramID insertObject:temp atIndex:i];
    }
    return self;
}
@end
