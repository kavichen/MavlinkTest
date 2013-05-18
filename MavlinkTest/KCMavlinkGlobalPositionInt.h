//
//  KCMavlinkGlobalPositionInt.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"
@interface KCMavlinkGlobalPositionInt : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *timeBootMS;
    NSNumber *lat;
    NSNumber *lon;
    NSNumber *alt;
    NSNumber *relativeAlt;
    NSNumber *vx;
    NSNumber *vy;
    NSNumber *vz;
    NSNumber *hdg;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *timeBootMS;
@property (nonatomic,strong) NSNumber *lat;
@property (nonatomic,strong) NSNumber *lon;
@property (nonatomic,strong) NSNumber *alt;
@property (nonatomic,strong) NSNumber *relativeAlt;
@property (nonatomic,strong) NSNumber *vx;
@property (nonatomic,strong) NSNumber *vy;
@property (nonatomic,strong) NSNumber *vz;
@property (nonatomic,strong) NSNumber *hdg;

- (KCMavlinkGlobalPositionInt *)initWith:(mavlink_message_t *)msg;

@end
