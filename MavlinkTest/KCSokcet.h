//
//  KCSokcet.h
//  MavlinkTest
//
//  Created by kavi chen on 13-5-6.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"

@interface KCSokcet : GCDAsyncUdpSocket<GCDAsyncUdpSocketDelegate>
{
    NSData *rawData;
    NSString *clientAddress;
}

- (KCSokcet *)init;
- (BOOL)bindToServer;
- (BOOL)bindToClient;
- (BOOL)beginReceiving;
//- (NSData *)returnRawData;
//- (void)processRawData;
//@property (nonatomic,strong) NSData *rawData;
//@property (nonatomic,strong) NSString *clientAddress;
@end



