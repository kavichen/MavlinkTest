//
//  KCMavlinkMessage.m
//  MavlinkTest
//
//  Created by kavi chen on 13-7-12.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMavlinkMessage.h"


@implementation KCMavlinkMessage
@synthesize aCheckSum = _aCheckSum;
@synthesize aMagic = _aMagic;
@synthesize lengthOfPayload = _lengthOfPayload;
@synthesize sequenceOfPacket = _sequenceOfPacket;
@synthesize senderSystemID = _senderSystemID;
@synthesize senderComponentID = _senderComponentID;
@synthesize msgID = _msgID;
@synthesize payload64 = _payload64;

- (KCMavlinkMessage *)init
{
    self = [super init];
    
}

@end
