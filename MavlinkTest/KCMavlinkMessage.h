//
//  KCMavlinkMessage.h
//  MavlinkTest
//
//  Created by kavi chen on 13-7-12.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"

@interface KCMavlinkMessage : NSObject
@property (nonatomic,strong) NSNumber *aCheckSum;
@property (nonatomic,strong) NSNumber *aMagic;
@property (nonatomic,strong) NSNumber *lengthOfPayload;
@property (nonatomic,strong) NSNumber *sequenceOfPacket;
@property (nonatomic,strong) NSNumber *senderSystemID;
@property (nonatomic,strong) NSNumber *senderComponentID;
@property (nonatomic,strong) NSNumber *msgID;
@property (nonatomic,strong) NSArray *payload64;

@end
