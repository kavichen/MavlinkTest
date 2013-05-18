//
//  KCMavlinkCommandACK.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkCommandACK : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *command;
    NSNumber *result;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *command;
@property (nonatomic,strong) NSNumber *result;

- (KCMavlinkCommandACK *)initWith:(mavlink_message_t *)msg;

@end
