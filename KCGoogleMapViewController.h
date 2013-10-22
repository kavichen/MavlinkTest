//
//  KCGoogleMapViewController.h
//  MavlinkTest
//
//  Created by kavi chen on 13-10-15.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "KCLocationDelegate.h"
#import "KCViewController.h"

@interface KCGoogleMapViewController : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate,KCLocationDelegate>
@property (nonatomic,strong) CLLocationManager *locationManger;
@end
