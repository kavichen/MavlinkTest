//
//  KCMavlinkRawIMU.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkRawIMU : NSObject{
    NSNumber *mavID;
    NSNumber *timeUsec;
    NSNumber *xAcc;
    NSNumber *yAcc;
    NSNumber *zAcc;
    NSNumber *xGyro;
    NSNumber *yGyro;
    NSNumber *zGyro;
    NSNumber *xMag;
    NSNumber *yMag;
    NSNumber *zMag;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *timeUsec;
@property (nonatomic,strong) NSNumber *xAcc;
@property (nonatomic,strong) NSNumber *yAcc;
@property (nonatomic,strong) NSNumber *zAcc;
@property (nonatomic,strong) NSNumber *xGyro;
@property (nonatomic,strong) NSNumber *yGyro;
@property (nonatomic,strong) NSNumber *zGyro;
@property (nonatomic,strong) NSNumber *xMag;
@property (nonatomic,strong) NSNumber *yMag;
@property (nonatomic,strong) NSNumber *zMag;

- (KCMavlinkRawIMU *)initWith:(mavlink_message_t *)msg;
@end
