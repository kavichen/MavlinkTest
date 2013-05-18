//
//  KCMavlinkParamRequestRead.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkParamRequestRead : NSObject{
    NSNumber *mavID;
    NSNumber *paraIndex;
    NSNumber *targetSystem;
    NSNumber *targetComponent;
    NSMutableArray *paramID;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *paraIndex;
@property (nonatomic,strong) NSNumber *targetSystem;
@property (nonatomic,strong) NSNumber *targetComponent;
@property (nonatomic,strong) NSMutableArray *paramID;

- (KCMavlinkParamRequestRead *)initWith:(mavlink_message_t *)msg;

@end
