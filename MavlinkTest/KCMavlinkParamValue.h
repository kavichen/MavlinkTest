//
//  KCMavlinkParamValue.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkParamValue : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *paramValue;
    NSNumber *paramCount;
    NSNumber *paramIndex;
    NSMutableArray *paraID;
    NSNumber *paramType;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *paramValue;
@property (nonatomic,strong) NSNumber *paramCount;
@property (nonatomic,strong) NSNumber *paramIndex;
@property (nonatomic,strong) NSMutableArray *paramID;
@property (nonatomic,strong) NSNumber *paramType;

- (KCMavlinkParamValue *)initWith:(mavlink_message_t *)msg;

@end
