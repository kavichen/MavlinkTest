//
//  KCMavlinkMissionItem.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkMissionItem : NSObject{
    NSNumber *mavID;
    NSNumber *param1;
    NSNumber *param2;
    NSNumber *param3;
    NSNumber *param4;
    NSNumber *x;
    NSNumber *y;
    NSNumber *z;
    NSNumber *seq;
    NSNumber *command;
    NSNumber *targetSystem;
    NSNumber *targetComponent;
    NSNumber *frame;
    NSNumber *current;
    NSNumber *autoContinue;
}

@property (nonatomic, strong) NSNumber *mavID;
@property (nonatomic, strong) NSNumber *param1;
@property (nonatomic, strong) NSNumber *param2;
@property (nonatomic, strong) NSNumber *param3;
@property (nonatomic, strong) NSNumber *param4;
@property (nonatomic, strong) NSNumber *x;
@property (nonatomic, strong) NSNumber *y;
@property (nonatomic, strong) NSNumber *z;
@property (nonatomic, strong) NSNumber *seq;
@property (nonatomic, strong) NSNumber *command;
@property (nonatomic, strong) NSNumber *targetSystem;
@property (nonatomic, strong) NSNumber *targetComponent;
@property (nonatomic, strong) NSNumber *frame;
@property (nonatomic, strong) NSNumber *current;
@property (nonatomic, strong) NSNumber *autoContinue;

- (KCMavlinkMissionItem *)initWith:(mavlink_message_t *)msg;

@end
