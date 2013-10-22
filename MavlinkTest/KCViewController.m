//
//  KCViewController.m
//  MavlinkTest
//
//  Created by kavi chen on 4/29/13.
//  Copyright (c) 2013 kavi chen. All rights reserved.
//

#import "KCViewController.h"
#import "GCDAsyncUdpSocket.h"
#import "KCMavlinkIO.h"
#import "KCSokcet.h"
#define CLIENT_IP @"127.0.0.1"

#ifndef BUFFER_LENGTH
#define BUFFER_LENGTH 2041
#endif

@interface KCViewController (){
    unsigned char buf[BUFFER_LENGTH];
    NSInteger len;
    int port;
    NSInteger isSendHB;
    NSInteger isSendStart;
    KCMavlinkIO *mavlinkIO;
    NSInteger targetSysID;
    NSInteger targetCompID;
    NSNumber *thisSystemID;
    NSNumber *thisComponentID;
    CLLocationCoordinate2D currentBoatLocation;
    NSNumber *boatHGD;
}
//@property (nonatomic,strong) GCDAsyncUdpSocket *server_socket;
//@property (strong, nonatomic) IBOutlet UIButton *heartBeat;
@property (nonatomic,strong) KCSokcet *localSocket;
@property (nonatomic,strong) KCSokcet *serverSocket;
@property (nonatomic,strong) KCMavlinkIO *mavlink;
@property (nonatomic,strong) NSString *address;
//@property int port;
@property (nonatomic,strong) NSData *sendData;
@property (nonatomic,strong) KCMavlinkHeartBeat *heartBeat;
@property (nonatomic,strong) NSNumber *thisSystemID;
@property (nonatomic,strong) NSNumber *thisComponentID;
@property (strong, nonatomic) IBOutlet UILabel *heartBeatRealData;
@property (strong, nonatomic) IBOutlet UILabel *hdgRealData;
@property (strong, nonatomic) IBOutlet UILabel *iPhoneHDGLabel;
@property (strong, nonatomic) IBOutlet UILabel *iPhoneHDGLabel2;

@property (strong, nonatomic) IBOutlet UILabel *iPhoneLonLabel;
@property (strong, nonatomic) IBOutlet UILabel *iPhoneLatLabel;

@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UILabel *realLatitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *realLongitudeLabel;
@end

@implementation KCViewController
//@synthesize server_socket = _server_socket;

@synthesize localSocket = _localSocket;
@synthesize serverSocket = _serverSocket;
@synthesize mavlink = _mavlink;
@synthesize address = _address;
@synthesize sendData = _sendData;
@synthesize heartBeat = _heartBeat;
@synthesize thisSystemID = _thisSystemID;
@synthesize thisComponentID = _thisComponentID;
@synthesize locationManager = _locationManager;
@synthesize showBoatLocationDataDelegate = _shwoBoatLocationDataDelegate;


-(GCDAsyncUdpSocket *)serverSocket
{
    if(!_serverSocket) {
        _serverSocket = [[KCSokcet alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _serverSocket;
}
-(GCDAsyncUdpSocket *)localSocket
{
    if (!_localSocket) {
        _localSocket = [[KCSokcet alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _localSocket;
}

- (KCMavlinkIO *)mavlink
{
    if (!_mavlink) {
        _mavlink = [[KCMavlinkIO alloc] init];
    }
    return _mavlink;
}

- (NSNumber *)thisSystemID
{
    if (!_thisSystemID) {
        _thisSystemID = [[NSNumber alloc] initWithUnsignedShort:0];
    }
    return _thisSystemID;
}

- (NSNumber *)thisComponentID
{
    if(!_thisComponentID) {
        _thisComponentID = [[NSNumber alloc] initWithUnsignedShort:0];
    }
    return _thisComponentID;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.localSocket bindToServer];
    [self.localSocket beginReceiving];
    isSendHB = 0;
    self.address = @"192.168.1.223";
    port = 14550;
    memset(buf, 0, BUFFER_LENGTH);
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    locationManager.heading = YES;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.headingFilter = 1;
    
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
}


/**
 *  Location coordinate update
 *
 *  @param manager
 *  @param locations
 */

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentBoatLocation = [[locations lastObject] coordinate];
//    NSLog(@"%f",currentBoatLocation.latitude);
//    NSLog(@"%f",currentBoatLocation.longitude);
    NSNumber *longitude =[[NSNumber alloc] initWithFloat:currentBoatLocation.longitude];
    self.iPhoneLonLabel.text = [longitude stringValue];
    NSNumber *latitude = [[NSNumber alloc] initWithFloat:currentBoatLocation.latitude];
    self.iPhoneLatLabel.text = [latitude stringValue];
    
    if([self.showBoatLocationDataDelegate respondsToSelector:@selector(sendBoatHeading:andCoordinate:)]){
//        NSLog(@"#1 showBoatLocationDataDelegate sent");
        [self.showBoatLocationDataDelegate sendBoatHeading:boatHGD andCoordinate:currentBoatLocation];
        
    }
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    CLLocationCoordinate2D loc = [newLocation coordinate];
////    float longitude = loc.longitude;
////    float latitude = loc.latitude;
//    NSNumber *longitude =[[NSNumber alloc] initWithFloat:loc.longitude];
//    self.iPhoneLonLabel.text = [longitude stringValue];
//    NSNumber *latitude = [[NSNumber alloc] initWithFloat:loc.latitude];
//    self.iPhoneLatLabel.text = [latitude stringValue];
//    
////    CLLocationDirection hdgTrue = [new]
//}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    CLLocationDirection iPhonetureHDG = [newHeading trueHeading];
    CLLocationDirection iPhoneMagHDG = [newHeading magneticHeading];
    NSNumber *tureHDG = [[NSNumber alloc] initWithFloat:iPhonetureHDG];
    NSNumber *magHDG = [[NSNumber alloc] initWithFloat:iPhoneMagHDG];
    
    self.iPhoneHDGLabel.text = [tureHDG stringValue];
    self.iPhoneHDGLabel2.text = [magHDG stringValue];
}

    
- (void)udpSocket:(GCDAsyncUdpSocket *)socket
   didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
    mavlink_message_t msg;
    mavlinkIO = [[KCMavlinkIO alloc] initWithData:data into:&msg];
    switch ([mavlinkIO.msgid integerValue]) {
        case 0:{
            self.heartBeat = [[KCMavlinkHeartBeat alloc] initWith:&msg];
            self.heartBeatRealData.text = @"heart beat";
//            self.heartBeatRealData.text = @"";
            targetSysID = [mavlinkIO.sysid integerValue];
            targetCompID = [mavlinkIO.compid integerValue];
//            NSLog(@"targetSysID = %d", targetSysID);
//            NSLog(@"targetCompID = %d", targetCompID);
//            KCMavlinkHeartBeat *mavlinkHeartBeat = [[KCMavlinkHeartBeat alloc] initWith:&msg];
//            NSLog(@"----------------");
//            NSLog(@"Receive a HeartBeat");
//            NSLog(@"customMode = %u",[self.heartBeat.customMode unsignedIntegerValue]);
//            NSLog(@"type = %hhu",[self.heartBeat.type unsignedCharValue]);
//            NSLog(@"autopilot = %hhu",[self.heartBeat.autopilot unsignedCharValue]);
//            NSLog(@"base mode = %hhu",[self.heartBeat.baseMode unsignedCharValue]);
//            NSLog(@"system status = %hhu",[self.heartBeat.systemStatus unsignedCharValue]);
//            NSLog(@"MAVLink Version = %hhu",[self.heartBeat.mavlinkVersion unsignedCharValue]);
            break;
        }
        case 1:{
            KCMavlinkSysStatus *mavlinkSysStatus = [[KCMavlinkSysStatus alloc] initWith:&msg];
//            NSLog(@"----------------");
//            NSLog(@"System Status = %@",mavlinkSysStatus.mavID);
            break;
        }
        case 33:{
//            self.realData.text = 0;
            self.heartBeatRealData.text = @"";
            mavlink_global_position_int_t mavlinkGlabalPosition;
            mavlink_msg_global_position_int_decode(&msg, &mavlinkGlabalPosition);
            NSNumber *hdg = [[NSNumber alloc] initWithUnsignedInt:mavlinkGlabalPosition.hdg/100];
            if (boatHGD == nil) {
                boatHGD = [[NSNumber alloc] initWithFloat:0.0f];
            }else{
                boatHGD = hdg;
            }
            
            NSNumber *lat = [[NSNumber alloc] initWithInt:mavlinkGlabalPosition.lat];
            NSNumber *lon = [[NSNumber alloc] initWithInt:mavlinkGlabalPosition.lon];
            #pragma location delegate
//            [showBoatLocationDataDelegate sendBoatLocation:lat and:lon];
            
            if([self.showBoatLocationDataDelegate respondsToSelector:@selector(sendBoatHeading:andCoordinate:)]){
//                NSLog(@"#1 showBoatLocationDataDelegate sent!");
                [self.showBoatLocationDataDelegate sendBoatHeading:hdg andCoordinate:currentBoatLocation];

            }
            self.realLatitudeLabel.text = [lat stringValue];
            self.realLongitudeLabel.text = [lon stringValue];
            self.hdgRealData.text = [hdg stringValue];
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Send HeartBeat Command */

- (IBAction)sendHeartBeat:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if (isSendHB == 0 ) {
            isSendHB = 1;
            [self performSelectorInBackground:@selector(loopHeartBeat) withObject:NULL];
        }else{
            isSendHB = 0;
        }
        
    });
}

- (void)loopHeartBeat
{
    while (isSendHB == 1) {
        long tag = 0;
        mavlink_message_t msg;
        mavlink_msg_heartbeat_pack(1, 200, &msg, MAV_TYPE_FIXED_WING, MAV_AUTOPILOT_GENERIC, MAV_MODE_GUIDED_ARMED, 0, MAV_STATE_ACTIVE);
        //    unsigned char *buf;
        //    buf = (unsigned char *)malloc(sizeof(unsigned char)*2041);
        len = mavlink_msg_to_send_buffer(buf, &msg);
        NSLog(@"Send a HeartBeat");
        self.sendData = [NSData dataWithBytes:buf length:len];
        [self.serverSocket sendData:self.sendData toHost:self.address port:port withTimeout:-1 tag:tag];
        sleep(1);
        
    }

}


/* Send Start Command */
- (IBAction)sendStartComm:(UIButton *)sender
{
    long tag = 0;
    mavlink_message_t msg;
    mavlink_msg_command_long_pack(1, 200, &msg, targetSysID, targetCompID, MAV_CMD_NAV_TAKEOFF, 0, 0, 0, 0, 0, 0, 0, 0);
//    KCMavlinkCommandLong *commandLong;
//    NSNumber *cmd = [[NSNumber alloc] initWithUnsignedShort:MAV_CMD_NAV_TAKEOFF];
//    [commandLong packCommandLongMsg:self.mavlink fromSystemID:self.thisSystemID fromComponentID:self.thisSystemID Command:cmd Confirmation:0 Param1:0 Param2:0 Param3:0 Param4:0 Param5:0 Param6:0 Param7:0 intoMessage:0];
    len = mavlink_msg_to_send_buffer(buf, &msg);
    NSLog(@"len = %d",len);
    NSLog(@"Send TAKEOFF");
    self.sendData = [NSData dataWithBytes:buf length:len];
    [self.serverSocket sendData:self.sendData toHost:self.address port:port withTimeout:-1 tag:tag];
}

/* Send Real Start Command */
- (IBAction)sendRealStartComm:(UIButton *)sender
{
    long tag = 0;
    mavlink_message_t msg;
    
    KCMavlinkCommandLong *commandLong = [[KCMavlinkCommandLong alloc] init];
    NSNumber *cmd = [[NSNumber alloc] initWithUnsignedShort:MAV_CMD_NAV_TAKEOFF];
    [commandLong packCommandLongMsg:self.mavlink fromSystemID:self.thisSystemID fromComponentID:self.thisSystemID Command:cmd Confirmation:0 Param1:0 Param2:0 Param3:0 Param4:0 Param5:0 Param6:0 Param7:0 intoMessage:&msg];
    len = mavlink_msg_to_send_buffer(buf, &msg);
    NSLog(@"len = %d",len);
    self.sendData = [NSData dataWithBytes:buf length:len];
    [self.serverSocket sendData:self.sendData toHost:self.address port:port withTimeout:-1 tag:tag];
}

/* Send Slow Command */
- (IBAction)sendSlowComm:(UIButton *)sender
{
    long tag = 0;
    mavlink_message_t msg;
    mavlink_msg_command_long_pack(1, 200, &msg, targetSysID, targetCompID, MAV_CMD_OVERRIDE_GOTO, 0, 0, 0, 0, 0, 0, 0, 0);
    len = mavlink_msg_to_send_buffer(buf, &msg);
    NSLog(@"Send GOTO");
    self.sendData = [NSData dataWithBytes:buf length:len];
    [self.serverSocket sendData:self.sendData toHost:self.address port:port withTimeout:-1 tag:tag];
}


/* Send Stop Command */
- (IBAction)sendStopComm:(UIButton *)sender
{
    long tag = 0;
    mavlink_message_t msg;
    mavlink_msg_command_long_pack(1, 200, &msg, targetSysID, targetCompID, MAV_CMD_PREFLIGHT_REBOOT_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0, 0);
    len = mavlink_msg_to_send_buffer(buf, &msg);
    NSLog(@"Send REBOOT_SHUTDOWN");
    self.sendData = [NSData dataWithBytes:buf length:len];
    [self.serverSocket sendData:self.sendData toHost:self.address port:port withTimeout:-1 tag:tag];
}

- (void)viewDidUnload {
    [self setHeartBeatRealData:nil];
    [self setHdgRealData:nil];
    [self setIPhoneHDGLabel:nil];
    [self setIPhoneLonLabel:nil];
    [self setIPhoneLatLabel:nil];
    [self setIPhoneHDGLabel:nil];
    [self setIPhoneHDGLabel2:nil];
    [self setRealLatitudeLabel:nil];
    [self setRealLongitudeLabel:nil];
    [super viewDidUnload];
    free(buf);
}

@end
