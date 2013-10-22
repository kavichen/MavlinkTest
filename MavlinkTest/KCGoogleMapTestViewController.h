//
//  KCGoogleMapTestViewController.h
//  MavlinkTest
//
//  Created by kavi chen on 13-10-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "KCLocationDelegate.h"
#import "KCViewController.h"

@interface KCGoogleMapTestViewController : UIViewController<CLLocationManagerDelegate,KCLocationDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
//@property (nonatomic,strong) id<KCLocationDelegate> locationDelegate;
@end
