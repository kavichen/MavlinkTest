//
//  KCGoogleMapViewController.m
//  MavlinkTest
//
//  Created by kavi chen on 13-10-15.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCGoogleMapViewController.h"
#import <sqlite3.h>
#define DBName @"Database.sqlite"
#define PATHTABLENAME @"PATH"
#define PATHID @"pathID"
#define PATHNAME @"pathName"
#define PATHCOORDINATEID @"pathCoordinateID"
#define PATHLENGTH @"pathLength"

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
    NSArray *currentPath;
    GMSMutablePath *testPath;
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
 */
- (void)loadMapView
{
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
//    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
    [mapView_ addObserver:self
           forKeyPath:@"myLocation"
              options:NSKeyValueObservingOptionNew
              context:NULL];
    
    self.view = mapView_;

// Ask for my location data after the map has already been added to the UI
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES; // myLocationButton 只是用来测试，当导航板返回 boat current location 的时候，直接用导航板发过来的 coordinate，去掉手机自己的myLocation 即可
    });
    
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
    //load boatLocationMarker
    boatLocationMarker = [[GMSMarker alloc] init];
    boatLocationMarker.icon = [UIImage imageNamed:@"up.png"];
    boatLocationMarker.position = currentBoatLocation;
    boatLocationMarker.layer.anchorPoint = CGPointMake(0.5, 0.5);
    boatLocationMarker.title = @"My Current Location";
    boatLocationMarker.map = mapView_;
    mapView_.selectedMarker = boatLocationMarker;
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
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSString *documentDirectory = [paths objectAtIndex:0];
//    NSString *filePath = [NSString stringWithString:[documentDirectory stringByAppendingString:kFilename]];
//    NSLog(@"%@",filePath);
//    [self openDatabase];
    // load database
    [self createDatabase];
//    [self removeFilesInSandbox:nil];

    // load UI View Part
    [self loadMapView];
    UIButton *addPathButton = [self buildAddPathButton];
    [addPathButton addTarget:self action:@selector(addPathButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [mapView_ addSubview:addPathButton];
}

// sqlite part
//-(void)applicationWillResignActive:(NSNotification *)notification
//{
//    sqlite3* database;
//    if(sqlite3_open([[self dataFilePath] UTF8String], &database) !=SQLITE_OK){
//        sqlite3_close(database);
//        NSAssert(0,@"Failed to open database");
//    }
//    for (int i = 1; i<= 4; i++) {
//        NSString *fieldName = [[NSString alloc] initWithFormat:@"field%d",i];
//        UITextField *field = [self valueForKey:fieldName];
//        
//        char *update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA)"
//                        " VALUES(?,?);";
//        
//        char *errorMsg = NULL;
//        sqlite3_stmt *stmt;
//        if (sqlite3_prepare_v2(database, update, -1,&stmt, nil) == SQLITE_OK){
//            sqlite3_bind_int(stmt, 1, i);
//            sqlite3_bind_text(stmt, 2, [field.text UTF8String], -1, NULL);
//        }
//        if (sqlite3_step(stmt)!=SQLITE_DONE){
//            NSAssert(0,@"Error updating table:%s",errorMsg);
//        }
//        sqlite3_finalize(stmt);
//    }
//}

-(UIButton *)buildAddPathButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(mapView_.bounds.size.width - 100, mapView_.bounds.size.height -  100,100,20);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [button setTitle:@"Button" forState:UIControlStateNormal];
    return button;
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

- (void)addWayPointIntoCurrentPath
{
    if ([currentPath firstObject] == nil) {
//        NSMutableDictionary *initalWayPoint = [[NSMutableDictionary alloc] initWithObjectsAndKeys:,@"initalWayPoint",nil];
        
    }
}

- (void)addNewMarkerIntoPath:(CLLocationCoordinate2D)coordinate
{
    GMSMarker *marker = [GMSMarker markerWithPosition:coordinate];
    marker.position = coordinate;
//    marker.title = @"test";
    marker.appearAnimation = kGMSMarkerAnimationPop;
//    marker.snippet = @"ok";
    marker.infoWindowAnchor = CGPointMake(0.5f, 0.5f); //
    marker.draggable = YES;
    marker.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];
    marker.map = mapView_;
    
    [testPath addCoordinate:marker.position];
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (testPath == nil) {
        testPath = [GMSMutablePath path];
    }
    [self addNewMarkerIntoPath:coordinate];
}


- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    GMSPolyline *polyLine = [GMSPolyline polylineWithPath:testPath];
    polyLine.strokeColor = [UIColor redColor];
    polyLine.strokeWidth = 3.0f;
    polyLine.tappable = YES;
    polyLine.title = @"test poly line";
    polyLine.map = mapView_;
}


- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    KCCustomInfoWindow *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
//    infoWindow.data.text = @"1.1";
//    NSLog(@"%@",infoWindow.data.text);
    return infoWindow;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    mapView.selectedMarker = marker;
    NSLog(@"%f",marker.position.latitude);
    return YES;
}

# pragma mark - SQLite Process
-(void)createDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [paths objectAtIndex:0];
    NSString *databaseDirectoryPath = [self checkDirectoryExitOrNot:@"Database" inPath:documentDirectoryPath];
    NSString *databaseFilePath = [NSString stringWithFormat:@"%@/%@",databaseDirectoryPath,DBName];

    if (sqlite3_open([databaseFilePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Failed to open database");
    }
    
    NSString *createCoordinateTable =
                                    @"CREATE TABLE IF NOT EXISTS coordinate"
                                     "("
                                     "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                                     "latitude REAL NOT NULL,"
                                     "longitude REAL NOT NULL"
                                     ")";

    NSString *createPathTable =
                               @"CREATE TABLE IF NOT EXISTS path"
                                "("
                                "id INTEGER PRIMARY KEY NOT NULL,"
                                "name TEXT,"
                                "coordinateid INTEGER NOT NULL,"
                                "length REAL,"
                                "FOREIGN KEY (coordinateid) REFERENCES coordinate(id) ON DELETE CASCADE ON UPDATE CASCADE"
                                ")";

    NSString *createBelongTable =
                                @"CREATE TABLE IF NOT EXISTS belong"
                                 "("
                                 "pathid INTEGER,"
                                 "coordinateid INTEGER,"
                                 "orderno INTEGER NOT NULL,"
                                 "FOREIGN KEY (pathid) REFERENCES coordinate(id) ON DELETE CASCADE ON UPDATE CASCADE,"
                                 "FOREIGN KEY (coordinateid) REFERENCES path(id) ON DELETE CASCADE ON UPDATE CASCADE,"
                                 "PRIMARY KEY (pathid,coordinateid)"
                                 ")";

    char *errorMsg;
    if (sqlite3_exec(database, [createPathTable UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table:%s",errorMsg);
    }
    if (sqlite3_exec(database, [createCoordinateTable UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table:%s",errorMsg);
    }
    if (sqlite3_exec(database, [createBelongTable UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table:%s",errorMsg);
    }
}

-(void)execSQL:(NSString *)sql
{
    char *errorMsg;
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK) {
        sqlite3_close(database);
       NSAssert(0, @"execute error: %s",errorMsg);
    }
}
#pragma marker - Directory

/**
 *  检测文件夹是否存在在某个路径下
 *  如果存在，返回该文佳夹路径
 *  如果不存在，在该路径下创建该文件夹，并返回其路径
 *
 *  @param directoryName 文件夹名字
 *  @param path 路径
 *
 *  @return 该文件夹路径
 */
-(NSString *)checkDirectoryExitOrNot:(NSString *)directoryName inPath:(NSString *)path
{
    NSString *directoryInPath = [NSString stringWithFormat:@"%@/%@/",path,directoryName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exited = [fileManager fileExistsAtPath:directoryInPath];
    if(!exited){
        [fileManager createDirectoryAtPath:directoryInPath withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        // 可以设置第一次启动的参数
    }
    return directoryInPath;
}

-(void)removeFilesInSandbox:(NSString *)filename
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSLog(@"path = %@",paths);
    NSString *documentDirectory = [paths objectAtIndex:0];
//    NSLog(@"documentDirectory = %@",documentDirectory);
    NSError *error = nil;
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:documentDirectory error:&error];
//    NSLog(@"%@",directoryContents);
}
/*
NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS "
"(ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT);";
char *errorMsg;
if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
    sqlite3_close(database);
    NSAssert(0, @"Error creating table:%s",errorMsg);
}

NSString *query = @"SELECT ROW,FIELD_DATA FROM FIELDS ORDER BY ROW";
sqlite3_stmt *statement;
if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
{
    while (sqlite3_step(statement) == SQLITE_ROW) {
        int row = sqlite3_column_int(statement, 0);
        char *rowData = (char *)sqlite3_column_text(statement, 1);
        
        NSString *fieldName = [[NSString alloc] initWithFormat:@"field%d",row];
        NSString *fieldValue = [[NSString alloc] initWithUTF8String:rowData];
        
        UITextField *field = [self valueForKey:fieldName];
        field.text = fieldValue;
    }
    sqlite3_finalize(statement);
}
sqlite3_close(database);
*/

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
# pragma mark - Button Click Event
- (void)addPathButtonPressed
{
    NSLog(@"add path button pressed");
//    [mapView_ clear];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

@end
