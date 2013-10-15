//
//  KCMapViewController.m
//  MavlinkTest
//
//  Created by kavi chen on 13-8-12.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//#import <CoreGraphics/CoreGraphics.h>

@interface KCMapViewController ()
//@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSString *userCurrentLatitude;
@property (strong, nonatomic) NSString *userCurrentLongitude;
@property (strong, nonatomic) NSString *boatCurrentLatitude;
@property (strong, nonatomic) NSString *boatCurrentLongitude;

@end

@implementation KCMapViewController
//@synthesize mapView;
@synthesize userCurrentLatitude;
@synthesize userCurrentLongitude;
@synthesize boatCurrentLatitude;
@synthesize boatCurrentLongitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    userCurrentLongitude = @"";
    userCurrentLatitude = @"";
    
//    mapView = [[[MKMapView alloc] initWithFrame:[self.view.bounds]]];
    autoNaviMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    autoNaviMapView.mapType = MKMapTypeSatellite;
    autoNaviMapView.delegate = self;
    autoNaviMapView.showsUserLocation = YES;
//    [autoNaviMapView isZoomEnabled:YES]
//    self.mapView.isZoomEnabled = YES;
    
    [self.view addSubview:autoNaviMapView];
	// Do any additional setup after loading the view.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.latitude];
    NSString *longitude = [[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.longitude];
    
    userCurrentLatitude = latitude;
    userCurrentLongitude = longitude;
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta = 0.010;
    span.longitudeDelta = 0.010;
    region.span = span;
    region.center = [userLocation coordinate];
    
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
}

-(void)sendBoatLocation:(NSNumber *)boatLongitude and:(NSNumber *)boatLatitude
{
    self.boatCurrentLongitude = [boatLongitude stringValue];
    self.boatCurrentLatitude = [boatLatitude stringValue];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
