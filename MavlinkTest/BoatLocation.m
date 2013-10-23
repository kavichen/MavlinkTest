//
//  BoatLocation.m
//  MavlinkTest
//
//  Created by kavi chen on 13-10-23.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "BoatLocation.h"

@implementation BoatLocation
@synthesize theCoordinate;
@synthesize theHeading;
- (BoatLocation *)initBoatLocation
{
    BoatLocation *boatLocation = [[BoatLocation alloc] init];
    return boatLocation;
}

- (BoatLocation *)initBoatLocationWithCoordinate:(CLLocationCoordinate2D *)boatCoordinate
{
    BoatLocation *boatLocation = [self initBoatLocation];
    boatLocation.theCoordinate->latitude = boatCoordinate->latitude;
    boatLocation.theCoordinate->longitude = boatCoordinate->longitude;
    boatLocation.theHeading = [NSNumber numberWithInt:-1]; // Don't need to consider the heading direction of this boatLocation
    return boatLocation;
}

- (BoatLocation *)initWithCoordinate:(CLLocationCoordinate2D *)boatCoordinate andHeading:(NSNumber *)boatHeading
{
    BoatLocation *boatLocation = [self initBoatLocation];
    boatLocation.theHeading = boatHeading;
    boatLocation.theCoordinate->latitude = boatCoordinate->latitude;
    boatLocation.theCoordinate->longitude = boatCoordinate->longitude;
    
    return boatLocation;
}
@end
