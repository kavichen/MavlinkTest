//
//  KCMavlinkAttitude.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"
@interface KCMavlinkAttitude : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *timeBootMS;
    NSNumber *roll;
    NSNumber *pitch;
    NSNumber *yaw;
    NSNumber *rollSpeed;
    NSNumber *pitchSpeed;
    NSNumber *yawSpeed;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *timeBootMS;
@property (nonatomic,strong) NSNumber *roll;
@property (nonatomic,strong) NSNumber *pitch;
@property (nonatomic,strong) NSNumber *yaw;
@property (nonatomic,strong) NSNumber *rollSpeed;
@property (nonatomic,strong) NSNumber *pitchSpeed;
@property (nonatomic,strong) NSNumber *yawSpeed;

- (KCMavlinkAttitude *)initWith:(mavlink_message_t *)msg;

@end
