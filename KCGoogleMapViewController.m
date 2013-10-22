//
//  KCGoogleMapViewController.m
//  MavlinkTest
//
//  Created by kavi chen on 13-10-15.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCGoogleMapViewController.h"
const CLLocationDegrees nbLongitude = 121.597041; // inital longitude
const CLLocationDegrees nbLatitude = 29.858904;// inital latitude

@interface KCGoogleMapViewController ()
@property (nonatomic,strong) NSNumber *boatHeading;
@property (nonatomic,strong) NSNumber *previousHeading;
@end

@implementation KCGoogleMapViewController{
    GMSMapView *mapView_;
    GMSMarker *boatLocationMarker;
//    GMSMarker *myLocationMarker_;
    NSNumber *boatHeading;
    NSNumber *previousHeading;
    UIImageView *boatIcon;
    CLLocationCoordinate2D currentBoatLocation;
    GMSCameraPosition *currentBoatLocationCameraPosition;
    IBOutlet UIButton *updateButton;
    IBOutlet UIButton *zoomIn;
}
@synthesize locationManger = _locationManger;
@synthesize boatHeading = _boatHeading;
@synthesize previousHeading = _previousHeading;

#pragma getter and setter
-(NSNumber *)boatHeading
{
    if(!_boatHeading){
        _boatHeading = [[NSNumber alloc] initWithFloat:0.0f];
    }
    return _boatHeading;
}

-(NSNumber *)previousHeading
{
    if (!_previousHeading) {
        _previousHeading = [[NSNumber alloc] initWithFloat:0.0f];
    }
    return _previousHeading;
}
-(CLLocationManager *)locationManger
{
    if(!_locationManger){
        _locationManger = [[CLLocationManager alloc] init];
    }
    return _locationManger;
}

/**
 *  awakeFromNib 在调出 view 前就可以把delegete参数传递给 controller，viewDidLoad 中则不行
 */

- (void)awakeFromNib
{
    KCViewController *mainViewContrller = [self.tabBarController.viewControllers objectAtIndex:0];
    mainViewContrller.showBoatLocationDataDelegate = self;
    self.locationManger.delegate = self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *  首次载入 Google map
 *
 *  @param Longitude 经度坐标
 *  @param Latitude  纬度坐标
 */
- (void)loadMapView
{
//    CLLocationDegrees nbLongitude = 121.597041; // inital longitude
//    CLLocationDegrees nbLatitude = 29.858904; // inital latitude
    mapView_.delegate = self;
//    GMSCameraPosition *nbCameraPosition = [GMSCameraPosition cameraWithLatitude:nbLatitude longitude:nbLongitude zoom:8];
    currentBoatLocationCameraPosition = [[GMSCameraPosition alloc] initWithTarget:currentBoatLocation
                                                                             zoom:17
                                                                          bearing:0
                                                                     viewingAngle:0];
    
    mapView_  = [GMSMapView mapWithFrame:self.view.bounds camera:currentBoatLocationCameraPosition];
//    mapView_.myLocationEnabled = YES; // 打开之后无法显示boat icon
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.compassButton = YES;
    mapView_.indoorEnabled = NO; // 室内地图关闭
    self.view = mapView_;
    
    //load boatLocationMarker
}

#pragma mark - Animation Process
- (void)zoomToLevelAnimation:(NSNumber *)level
{
    CLLocationCoordinate2D currentLocation = currentBoatLocation;
    GMSCameraPosition *currentCameraPosition = [[GMSCameraPosition alloc] initWithTarget:currentLocation zoom:12 bearing:0 viewingAngle:0];
    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
    [CATransaction setValue:[NSNumber numberWithFloat:10.0f] forKey:kCATransactionAnimationDuration];
    [CATransaction setDisableActions:NO];
    [mapView_ animateToZoom:[level floatValue]];
    [CATransaction commit];
    [CATransaction setCompletionBlock:^{
        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithInt:10] forKey:kCATransactionAnimationDuration];
        [mapView_ animateToCameraPosition:currentCameraPosition];
        [CATransaction commit];
    }];
   
}

# pragma mark - icon image rotation process
- (void)processIconImage:(CLLocationDegrees)heading
{
//    NSLog(@"%d",heading);
    if(boatLocationMarker == nil)
    {
        boatLocationMarker = [[GMSMarker alloc] init];
        boatLocationMarker.icon = [UIImage imageNamed:@"up.png"];
        boatLocationMarker.position = currentBoatLocation;
        boatLocationMarker.layer.anchorPoint = CGPointMake(0.5, 0.5);
        boatLocationMarker.map = mapView_;
    }else{
//        NSLog(@"#3 adjust rotation");
        boatLocationMarker.rotation = heading;
    }
    boatLocationMarker.map = mapView_;
}

-(void)realHeadingRotationAnimation:(NSNumber *)previousHeading and:(NSNumber *)currentHeading
{
    float previous = -[previousHeading floatValue] * M_PI / 180.0f;
    float current = -[currentHeading floatValue]* M_PI / 180.0f;
    
    CABasicAnimation *realHeadingRotationAnimation;
    realHeadingRotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    realHeadingRotationAnimation.fromValue = [NSNumber numberWithFloat:previous];
    realHeadingRotationAnimation.toValue = [NSNumber numberWithFloat:current];
    realHeadingRotationAnimation.duration = 0.5f;
    [boatIcon.layer addAnimation:realHeadingRotationAnimation forKey:@"animateMyRotation"];
    boatIcon.transform = CGAffineTransformMakeRotation(current);
}



- (void)viewWillAppear:(BOOL)animated
{
    [self loadMapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void)sendBoatHeading:(NSNumber *)boatHeadingDirection andCoordinate:(CLLocationCoordinate2D)coordinate
{
    previousHeading = self.boatHeading;
    self.boatHeading = boatHeadingDirection;
    
    CLLocationDegrees heading = [boatHeadingDirection doubleValue];
    [self processIconImage:heading];
//    NSLog(@"#3,heading = %@",self.boatHeading); // 有信号
    currentBoatLocation = coordinate;
    [self realHeadingRotationAnimation:self.previousHeading and:self.boatHeading];
//    NSLog(@"#3 longitude = %f",currentBoatLocation.longitude);
//    NSLog(@"#3 latitude = %f",currentBoatLocation.latitude);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentBoatLocation = [[locations lastObject] coordinate];
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"You tapped at %f,%f",coordinate.latitude,coordinate.longitude);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
