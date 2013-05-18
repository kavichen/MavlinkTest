//
//  KCMavlinkParamSet.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkParamSet.h"

@implementation KCMavlinkParamSet
@synthesize mavID = _mavID;
@synthesize paramValue = _paramValue;
@synthesize targetSystem = _targetSystem;
@synthesize targetComponent = _targetComponent;
@synthesize paramID = _paramID;
@synthesize paramType = _paramType;

- (KCMavlinkParamSet *)initWith:(mavlink_message_t *)msg
{
    mavlink_param_set_t param_set;
    mavlink_msg_param_set_decode(msg, &param_set);
    NSNumber *temp = [[NSNumber alloc] init];
    self.mavID = [NSNumber numberWithInt:23];
    self.targetSystem = [NSNumber numberWithUnsignedChar:param_set.target_system];
    self.targetComponent = [NSNumber numberWithUnsignedChar:param_set.target_component];
    self.paramID = [[NSMutableArray alloc] initWithCapacity:16];
    for (int i = 0; i < 16 ; i ++) {
        temp = [NSNumber numberWithChar:param_set.param_id[i]];
        [self.paramID insertObject:temp atIndex:i];
    }
    self.paramType = [NSNumber numberWithUnsignedChar:param_set.param_type];
    return self;
}

@end
