//
//  BoatTrack.m
//  MavlinkTest
//
//  Created by kavi chen on 13-10-23.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "BoatTrack.h"

@implementation BoatTrack

@synthesize trackName;
@synthesize wayPointCoordinateArray;
@synthesize wayPointCount = _wayPointCount;

- (NSNumber *)wayPointCount
{
    _wayPointCount = [NSNumber numberWithInt:[wayPointCoordinateArray count]];
    return _wayPointCount;
}

-(BoatTrack *)initTrack
{
    BoatTrack *track = [[BoatTrack alloc] init];
    track.trackName = [NSString string];
    track.wayPointCoordinateArray = [NSArray array];
    return track;
}

-(BoatTrack *)initTrackWithName:(NSString *)name
{
    BoatTrack *boatTrack = [self initTrack];
    boatTrack.trackName = name;
    return boatTrack;
}

-(BoatTrack *)boatTrack:(BoatTrack *)track addWayPoint:(BoatLocation *)theWayPoint
{
    track.wayPointCoordinateArray = [track.wayPointCoordinateArray arrayByAddingObject:theWayPoint];
    return track;
}
@end
