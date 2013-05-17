//
//  KCMavlinkSystemTime.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkSystemTime : NSObject{
    @public
    NSNumber *mavID;
    NSNumber *timeUnixUsec;
    NSNumber *timeBootMS;
}

@property (nonatomic,strong) NSNumber *mavID;
@property (nonatomic,strong) NSNumber *timeUnixUsec;
@property (nonatomic,strong) NSNumber *timeBootMS;

@end
