//
//  KCMavlinkIO.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-6.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCSokcet.h"
#import "mavlink.h"
#import "KCMavlinkHeartBeat.h"

@interface KCMavlinkIO : NSObject{
@public
    NSNumber *version;
    NSNumber *msgid;
    NSNumber *len;
    NSNumber *seq;
    NSNumber *sysid;
    NSNumber *compid;
    NSNumber *checksum;
    NSMutableArray *payload;
//    NSMutableDictionary *mavlinkMsg;
//    mavlink_message_t msg;
//    uint16_t checksum; /// sent at end of packet
////    uint64_t payload64[(MAVLINK_MAX_PAYLOAD_LEN+MAVLINK_NUM_CHECKSUM_BYTES+7)/8];
}

@property (nonatomic,strong) NSNumber *version;
@property (nonatomic,strong) NSNumber *msgid;
@property (nonatomic,strong) NSNumber *len;
@property (nonatomic,strong) NSNumber *seq;
@property (nonatomic,strong) NSNumber *sysid;
@property (nonatomic,strong) NSNumber *compid;
@property (nonatomic,strong) NSNumber *checksum;
@property (nonatomic,strong) NSMutableArray *payload;
//@property (nonatomic,strong) NSMutableDictionary *mavlinkMsg;

- (KCMavlinkIO *)init;
- (KCMavlinkIO *)initWithData:(NSData *)rawData into:(mavlink_message_t *)msg;

@end



