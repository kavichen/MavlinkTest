//
//  KCMavlinkParamValue.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkParamValue.h"

@implementation KCMavlinkParamValue
@synthesize mavID = _mavID;
@synthesize paramValue = _paramValue;
@synthesize paramCount = _paramCount;
@synthesize paramID = _paramID;
@synthesize paramType = _paramType;
@synthesize paramIndex = _paramIndex;

- (KCMavlinkParamValue *)initWith:(mavlink_message_t *)msg
{
    mavlink_param_value_t param_value_t;
    mavlink_msg_param_value_decode(msg, &param_value_t);
    NSNumber *temp = [[NSNumber alloc] init];
    self.mavID = [NSNumber numberWithInt:22];
    self.paramValue = [NSNumber numberWithFloat:param_value_t.param_value];
    self.paramIndex = [NSNumber numberWithUnsignedShort:param_value_t.param_index];
    self.paramCount = [NSNumber numberWithUnsignedShort:param_value_t.param_count];
    self.paramID = [NSMutableArray arrayWithCapacity:16];
    for (int i = 0; i < 16; ++i) {
        temp = [NSNumber numberWithChar:param_value_t.param_id[i]];
        [self.paramID insertObject:temp atIndex:i];
    }
    self.paramType = [NSNumber numberWithUnsignedChar:param_value_t.param_type];
    return self;
}

@end
