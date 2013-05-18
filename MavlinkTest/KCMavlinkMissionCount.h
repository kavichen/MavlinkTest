//
//  KCMavlinkMissionCount.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkMissionCount : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *count;
    NSNumber *targetSystem;
    NSNumber *targetComponent;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *count;
@property (nonatomic,strong) NSNumber *targetSystem;
@property (nonatomic,strong) NSNumber *targetComponent;

- (KCMavlinkMissionCount *)initWith:(mavlink_message_t *)msg;
@end
