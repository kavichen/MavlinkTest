//
//  KCMavlinkParamSet.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkParamSet : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *paramValue;
    NSNumber *targetSystem;
    NSNumber *targetComponent;
    NSMutableArray *paramID;
    NSNumber *paramType;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *paramValue;
@property (nonatomic,strong) NSNumber *targetSystem;
@property (nonatomic,strong) NSNumber *targetComponent;
@property (nonatomic,strong) NSMutableArray *paramID;
@property (nonatomic,strong) NSNumber *paramType;

- (KCMavlinkParamSet *)initWith:(mavlink_message_t *)msg;

@end
