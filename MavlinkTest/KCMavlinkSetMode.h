//
//  KCMavlinkSetMode.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkSetMode : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *customMode;
    NSNumber *targetSystem;
    NSNumber *baseMode;
}

@property (nonatomic, strong) NSNumber *mavID;
@property (nonatomic, strong) NSNumber *customMode;
@property (nonatomic, strong) NSNumber *targetSystem;
@property (nonatomic, strong) NSNumber *baseMode;

- (KCMavlinkSetMode *)initWith:(mavlink_message_t *)msg;
@end
