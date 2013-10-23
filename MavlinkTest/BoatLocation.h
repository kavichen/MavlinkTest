//
//  BoatLocation.h
//  MavlinkTest
//
//  Created by kavi chen on 13-10-23.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BoatLocation : NSObject
{
    CLLocationCoordinate2D *theCoordinate;
    NSNumber *theHeading;
}
@property CLLocationCoordinate2D *theCoordinate;
@property (nonatomic,strong) NSNumber *theHeading;
@end
