//
//  KCMavlinkHeartBeat.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkHeartBeat : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *customMode;
    NSNumber *type;
    NSNumber *autopilot;
    NSNumber *baseMode;
    NSNumber *systemStatus;
    NSNumber *mavlinkVersion;
}

@property (nonatomic, strong) NSNumber *mavID;
@property (nonatomic, strong) NSNumber *customMode;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *autopilot;
@property (nonatomic, strong) NSNumber *baseMode;
@property (nonatomic, strong) NSNumber *systemStatus;
@property (nonatomic, strong) NSNumber *mavlinkVersion;

- (KCMavlinkHeartBeat *)initWith:(mavlink_message_t *)msg;

@end
