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
#import "KCViewController.h"
//#import <CoreGraphics/CoreGraphics.h>

@interface KCMapViewController ()
//@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSString *userCurrentLatitude;
@property (strong, nonatomic) NSString *userCurrentLongitude;
@property (strong, nonatomic) NSNumber *boatCurrentLatitude;
@property (strong, nonatomic) NSNumber *boatCurrentLongitude;

@property (strong, nonatomic) KCViewController *viewController;

@end

@implementation KCMapViewController
//@synthesize mapView;
@synthesize userCurrentLatitude = _userCurrentLatitude;
@synthesize userCurrentLongitude = _userCurrentLongitude;
@synthesize boatCurrentLatitude = _boatCurrentLatitude;
@synthesize boatCurrentLongitude = _boatCurrentLongitude;
@synthesize locationManager = _locationManager;

@synthesize viewController = _viewController;
@synthesize boatLocationDelegate = _boatLocationDelegate;

- (CLLocationManager *)locationManager
{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}
- (KCViewController *)viewController
{
    if(!_viewController){
        _viewController = [[KCViewController alloc] init];
    }
    return _viewController;
}

- (NSNumber *)boatCurrentLatitude
{
    if (!_boatCurrentLatitude) {
        _boatCurrentLatitude = [[NSNumber alloc] init];
    }
    return _boatCurrentLatitude;
}

- (NSNumber *)boatCurrentLongitude
{
    if(!_boatCurrentLongitude){
        _boatCurrentLongitude = [[NSNumber alloc] init];
    }
    return _boatCurrentLongitude;
}

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
    self.userCurrentLongitude = @"";
    self.userCurrentLatitude = @"";
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingHeading];
    self.viewController.showBoatLocationDataDelegate = self;
    
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
//    NSString *heading = [[NSString alloc] initWithFormat@"%f",userLocation.heading];
    
    self.userCurrentLatitude = latitude;
    self.userCurrentLongitude = longitude;
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta = 0.010;
    span.longitudeDelta = 0.010;
    region.span = span;
    region.center = [userLocation coordinate];
    
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    float oldRad = -manager.heading.trueHeading * M_PI/180.0f;
    float newRad = newHeading.trueHeading * M_PI / 180.0f;
    CABasicAnimation *theAnimation;
    theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    theAnimation.fromValue = [NSNumber numberWithFloat:oldRad];
    theAnimation.toValue = [NSNumber numberWithFloat:newRad];
    theAnimation.duration = 0.2f;
    // 添加标识点
}

//-(void)sendBoatLocation:(NSNumber *)boatLongitude and:(NSNumber *)boatLatitude
//{
//    self.boatCurrentLongitude = boatLatitude;
//    self.boatCurrentLatitude = boatLongitude;
//    NSLog(@"#1 %@",self.boatCurrentLongitude);
//    NSLog(@"#1 %@",self.boatCurrentLatitude);
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
