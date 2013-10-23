//
//  BoatTrack.h
//  MavlinkTest
//
//  Created by kavi chen on 13-10-23.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BoatLocation.h"

@interface BoatTrack : NSObject
{
    NSString *trackName;
    NSNumber *wayPointCount;
    NSArray *wayPointCoordinateArray; // an array of BoatLocation
}

@property (nonatomic,strong) NSString *trackName;
@property (nonatomic,strong) NSNumber *wayPointCount;
@property (nonatomic,strong) NSArray *wayPointCoordinateArray;

@end
