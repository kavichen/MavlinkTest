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
    NSNumber *boatHeading;
    NSNumber *previousHeading;
    UIImageView *boatIcon;
    CLLocationCoordinate2D currentBoatLocation;
    GMSCameraPosition *currentBoatLocationCameraPosition;
    IBOutlet UIButton *updateButton;
    IBOutlet UIButton *zoomIn;
    BOOL firstLocationUpdate;
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
//   3 mapView_.delegate = self;
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
    
    mapView_.delegate = self;
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
    self.view = mapView_;
       // 修改 myLocationButton 的位置
    for (UIView *view in mapView_.subviews) {
        NSLog(@"%@",view.description);
        if([[[view class] description] isEqualToString:@"GMSUISettingsView"]){
         
            CGRect frame = view.frame;
            frame.origin.x -= 75;
            frame.origin.y -= 60;
            view.frame = frame;
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
//        mapView_.myLocationEnabled = NO; // yes - 显示目前的所在地的小圆点
    });
    
    //load boatLocationMarker
    boatLocationMarker = [[GMSMarker alloc] init];
    boatLocationMarker.icon = [UIImage imageNamed:@"up.png"];
    boatLocationMarker.position = currentBoatLocation;
    boatLocationMarker.layer.anchorPoint = CGPointMake(0.5, 0.5);
    boatLocationMarker.map = mapView_;
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
    boatLocationMarker.rotation = heading;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self loadMapView];
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMapView];
}


-(void)sendBoatHeading:(NSNumber *)boatHeadingDirection andCoordinate:(CLLocationCoordinate2D)coordinate
{
    previousHeading = self.boatHeading;
    self.boatHeading = boatHeadingDirection;
    
    CLLocationDegrees heading = [boatHeadingDirection doubleValue]+55; // 55 初步调整参数
    [self processIconImage:heading];
//    NSLog(@"#3,heading = %@",self.boatHeading); // 有信号
    currentBoatLocation = coordinate;
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

- (void)mapView:(GMSMapView *)mapView_ didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"tap long time");
}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
{
    
}

# pragma mark - KVO updates
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    if (!firstLocationUpdate) {
        firstLocationUpdate = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:14];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [mapView_ removeObserver:self forKeyPath:@"myLocation"];
}

@end
