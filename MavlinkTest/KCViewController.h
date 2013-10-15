//
//  KCViewController.h
//  MavlinkTest
//
//  Created by kavi chen on 4/29/13.
//  Copyright (c) 2013 kavi chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mavlink.h"
#import "GCDAsyncUdpSocket.h"
#import "KCMavlinkHeartBeat.h"
#import "KCMavlinkSysStatus.h"
#import "KCMavlinkCommandLong.h"
#import <CoreLocation/CoreLocation.h>
#import "KCLocationDelegate.h"



@interface KCViewController : UIViewController<NSXMLParserDelegate,CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    id<KCLocationDelegate> showBoatLocationDataDelegate;
}

@property (nonatomic,strong) id<KCLocationDelegate> showBoatLocationDataDelegate;
@end
