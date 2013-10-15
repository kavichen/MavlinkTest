//
//  KCMapViewController.h
//  MavlinkTest
//
//  Created by kavi chen on 13-8-12.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCLocationDelegate.h"

@interface KCMapViewController : UIViewController<MKMapViewDelegate,KCLocationDelegate>
{
    MKMapView *autoNaviMapView;
//    id<KCLocationDelegate> boatLocationDelegate;
}
@end
