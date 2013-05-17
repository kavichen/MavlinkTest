//
//  KCMavlinkSysStatus.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkSysStatus.h"

@implementation KCMavlinkSysStatus
@synthesize mavID = _mavID;
@synthesize onboardControlSensorsPresent = _onboardControlSensorsPresent;
@synthesize onboardControlSensorsEnabled = _onboardControlSensorsEnabled;
@synthesize onboardControlSensorsHealth = _onboardControlSensorsHealth;
@synthesize load = _load;
@synthesize voltageBattery = _voltageBattery;
@synthesize currentBattery = _currentBattery;
@synthesize dropRateComm = _dropRateComm;
@synthesize errorsComm = _errorsComm;
@synthesize errorsCount_1 = _errorsCount_1;
@synthesize errorsCount_2 = _errorsCount_2;
@synthesize errorsCount_3 = _errorsCount_3;
@synthesize errorsCount_4 = _errorsCount_4;
@synthesize batteryRemaining = _batteryRemaining;

- (KCMavlinkSysStatus *)initWith:(mavlink_message_t *)msg
{
    mavlink_sys_status_t sys_status;
    mavlink_msg_sys_status_decode(msg, &sys_status);
    self.mavID  = [NSNumber numberWithInt:1];
    self.onboardControlSensorsPresent = [NSNumber numberWithUnsignedInt:sys_status.onboard_control_sensors_present];
    self.onboardControlSensorsEnabled = [NSNumber numberWithUnsignedInt:sys_status.onboard_control_sensors_enabled];
    self.onboardControlSensorsHealth = [NSNumber numberWithUnsignedInt:sys_status.onboard_control_sensors_health];
    self.load = [NSNumber numberWithUnsignedShort:sys_status.load];
    self.voltageBattery = [NSNumber numberWithUnsignedShort:sys_status.voltage_battery];
    self.currentBattery = [NSNumber numberWithShort:sys_status.current_battery];
    self.dropRateComm = [NSNumber numberWithUnsignedShort:sys_status.drop_rate_comm];
    self.errorsComm = [NSNumber numberWithUnsignedShort:sys_status.errors_comm];
    self.errorsCount_1 = [NSNumber numberWithUnsignedShort:sys_status.errors_count1];
    self.errorsCount_2 = [NSNumber numberWithUnsignedShort:sys_status.errors_count2];
    self.errorsCount_3 = [NSNumber numberWithUnsignedShort:sys_status.errors_count3];
    self.errorsCount_4 = [NSNumber numberWithUnsignedShort:sys_status.errors_count4];
    self.batteryRemaining = [NSNumber numberWithChar:sys_status.battery_remaining];
    return self;
}
@end
