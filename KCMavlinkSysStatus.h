//
//  KCMavlinkSysStatus.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkSysStatus : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *onboardControlSensorsPresent;
    NSNumber *onboardControlSensorsEnabled;
    NSNumber *onboardControlSensorsHealth;
    NSNumber *load;
    NSNumber *voltageBattery;
    NSNumber *currentBattery;
    NSNumber *dropRateComm;
    NSNumber *errorsComm;
    NSNumber *errorsCount_1;
    NSNumber *errorsCount_2;
    NSNumber *errorsCount_3;
    NSNumber *errorsCount_4;
    NSNumber *batteryRemaining;
}

@property (nonatomic,strong) NSNumber * mavID;
@property (nonatomic,strong) NSNumber * onboardControlSensorsPresent;
@property (nonatomic,strong) NSNumber * onboardControlSensorsEnabled;
@property (nonatomic,strong) NSNumber * onboardControlSensorsHealth;
@property (nonatomic,strong) NSNumber * load;
@property (nonatomic,strong) NSNumber * voltageBattery;
@property (nonatomic,strong) NSNumber * currentBattery;
@property (nonatomic,strong) NSNumber * dropRateComm;
@property (nonatomic,strong) NSNumber * errorsComm;
@property (nonatomic,strong) NSNumber * errorsCount_1;
@property (nonatomic,strong) NSNumber * errorsCount_2;
@property (nonatomic,strong) NSNumber * errorsCount_3;
@property (nonatomic,strong) NSNumber * errorsCount_4;
@property (nonatomic,strong) NSNumber * batteryRemaining;

- (KCMavlinkSysStatus * )initWith:(mavlink_message_t *)msg;

@end
