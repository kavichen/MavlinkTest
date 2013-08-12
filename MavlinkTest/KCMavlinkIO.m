//
//  KCMavlinkIO.m
//  MavlinkTest
//
//  Created by kavi chen on 13-5-6.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkIO.h"
#if MAVLINK_MAX_PAYLOAD_LEN && MAVLINK_NUM_CHECKSUM_BYTES
#define MAVLINK_MESSAGE_PAYLOAD_LENGTH (MAVLINK_MAX_PAYLOAD_LEN + MAVLINK_NUM_CHECKSUM_BYTES + 7)/8  //  33 length
#endif

@implementation KCMavlinkIO
@synthesize version = _version;
@synthesize msgid = _msgid;
@synthesize len = _len;
@synthesize seq = _seq;
@synthesize sysid = _sysid;
@synthesize compid = _compid;
@synthesize checksum = _checksum;
@synthesize payload = _payload;
//@synthesize mavlinkMsg = _mavlinkMsg;

#pragma mark - init
- (KCMavlinkIO *)init
{
    self = [super init];
    if (self) {
        return self;
    }
    return self;
}
- (KCMavlinkIO *)initWithData:(NSData *)rawData into:(mavlink_message_t *)msg
{
    self = [self init];
//    mavlink_message_t msg;
    mavlink_status_t status;
//    self.mavlinkMsg = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    Byte *buf = (Byte *)[rawData bytes];
    NSInteger length = [rawData length]; //Returns the number of bytes contained in the receiver.
    NSInteger lenPayload;
    NSNumber *temp = [[NSNumber alloc] init];
    for (int i = 0; i < length; ++i) {
        int flag = mavlink_parse_char(MAVLINK_COMM_0, buf[i], msg, &status);
        if (flag) {
            self.version = [NSNumber numberWithUnsignedChar:msg->magic];
            self.msgid = [NSNumber numberWithUnsignedChar:msg->msgid];
            self.len = [NSNumber numberWithUnsignedChar:msg->len];
            self.seq = [NSNumber numberWithUnsignedChar:msg->seq];
            self.sysid = [NSNumber numberWithUnsignedChar:msg->sysid];
            self.compid = [NSNumber numberWithUnsignedChar:msg->compid];
            self.checksum = [NSNumber numberWithUnsignedShort:msg->checksum];
            //[self determineLengthOfPayloadWithMessageID:&msg];
            self.payload = [NSMutableArray arrayWithCapacity:MAVLINK_MESSAGE_PAYLOAD_LENGTH];
            lenPayload = [self.len integerValue];
            for (int i = 0; i < lenPayload; ++i) {
                temp = [NSNumber numberWithLongLong:msg->payload64[i]];
                [self.payload insertObject:temp atIndex:i];
            }
        }
    }
    return self;
}

- (id)determineTypeWithMessageID:(mavlink_message_t *)msg
{
    switch ([self.msgid integerValue]) {
        case 0:
        {
            KCMavlinkHeartBeat *heartBeat = [[KCMavlinkHeartBeat alloc] initWith:msg];
            return heartBeat;
        }
            break;
            
        default:
            return NULL;
            break;
    }
    
}




@end
