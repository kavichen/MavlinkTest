//
//  KCMavlinkCommandLong.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-18.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mavlink.h"
#import "KCMavlinkIO.h"

@interface KCMavlinkCommandLong : NSObject
//@interface KCMavlinkCommandLong : NSObject{
//    @public
//    NSNumber *mavID;
//    NSNumber *param1;
//    NSNumber *param2;
//    NSNumber *param3;
//    NSNumber *param4;
//    NSNumber *param5;
//    NSNumber *param6;
//    NSNumber *param7;
//    NSNumber *command;
//    NSNumber *targetSystem;
//    NSNumber *targetComponent;
//    NSNumber *confirmation;
//}
//
//@property (nonatomic,strong) NSNumber *mavID;
//@property (nonatomic,strong) NSNumber *param1;
//@property (nonatomic,strong) NSNumber *param2;
//@property (nonatomic,strong) NSNumber *param3;
//@property (nonatomic,strong) NSNumber *param4;
//@property (nonatomic,strong) NSNumber *param5;
//@property (nonatomic,strong) NSNumber *param6;
//@property (nonatomic,strong) NSNumber *param7;
//@property (nonatomic,strong) NSNumber *command;
//@property (nonatomic,strong) NSNumber *targetSystem;
//@property (nonatomic,strong) NSNumber *targetComponent;
//@property (nonatomic,strong) NSNumber *confirmation;

//- (KCMavlinkCommandLong *)initWith:(mavlink_message_t *)msg;
- (void)packCommandLongMsg:(KCMavlinkIO *)mavlinkIO
              fromSystemID:(NSNumber *)sysID
           fromComponentID:(NSNumber *)compID
                   Command:(NSNumber *)com
              Confirmation:(NSNumber *)Con
                    Param1:(float)p1
                    Param2:(float)p2
                    Param3:(float)p3
                    Param4:(float)p4
                    Param5:(float)p5
                    Param6:(float)p6
                    Param7:(float)p7
               intoMessage:(mavlink_message_t *)message;

@end
