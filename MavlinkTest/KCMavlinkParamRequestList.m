//
//  KCMavlinkParamRequestList.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkParamRequestList.h"

@implementation KCMavlinkParamRequestList
@synthesize mavID = _mavID;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;

- (KCMavlinkParamRequestList *)initWith:(mavlink_message_t *)msg
{
    mavlink_param_request_list_t param_request_list;
    mavlink_msg_param_request_list_decode(msg, &param_request_list);
    self.mavID = [NSNumber numberWithInt:21];
    self.targetSystem = [NSNumber numberWithUnsignedChar:param_request_list.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:param_request_list.target_component];
    return self;
}
@end
