//
//  KCGoogleMapTestViewController.m
//  MavlinkTest
//
//  Created by kavi chen on 13-10-17.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCGoogleMapTestViewController.h"

@interface KCGoogleMapTestViewController (){
//    GMSMapView *_mapView;
    IBOutlet GMSMapView *_mapView;
    IBOutlet UIButton *updateCameraButton;
    IBOutlet UIButton *updateCameraButton2;
    GMSMarker *_LocationMarker;
    NSNumber *boatHeading;
}
@property (nonatomic,strong) NSNumber *boatHeading;
@end

@implementation KCGoogleMapTestViewController
@synthesize locationManager = _locationManager;
@synthesize boatHeading = _boatHeading;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GMSCameraPosition *sydney = [GMSCameraPosition cameraWithLatitude:-33.8683
                                                            longitude:151.2086
                                                                 zoom:6
                                                              bearing:0
                                                         viewingAngle:90];
	// Do any additional setup after loading the view.
    _mapView = [[GMSMapView alloc] initWithFrame:self.view.bounds];
    _mapView.camera = sydney;
    _mapView.settings.myLocationButton = YES;
    _mapView.settings.compassButton = YES;
    self.view = _mapView;

    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    KCViewController *dataSourceController = [self.tabBarController.viewControllers objectAtIndex:0];
    dataSourceController.showBoatLocationDataDelegate = self;
    [self processMarkerIcon];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)processMarkerIcon
{
    CLLocationCoordinate2D sydney = CLLocationCoordinate2DMake(-33.8683, 151.2086);
        CLLocationDegrees degrees = rand();
        
        GMSMarker *sydneyMarker = [GMSMarker markerWithPosition:sydney];
        sydneyMarker.title = @"sydney";
        sydneyMarker.icon = [UIImage imageNamed:@"up.png"];
        sydneyMarker.flat = YES;
        sydneyMarker.groundAnchor = CGPointMake(0.5, 0.5);
        sydneyMarker.rotation = degrees;
        sydneyMarker.map = _mapView;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
