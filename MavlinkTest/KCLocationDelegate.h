//
//  KCLocationDelegate.h
//  MavlinkTest
//
//  Created by kavi chen on 13-10-15.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KCLocationDelegate <NSObject>
-(void)sendBoatLocation:(NSNumber *)boatLongitude and:(NSNumber *)boatLatitude;
@end
