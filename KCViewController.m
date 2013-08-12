//
//  KCViewController.m
//  MavlinkTest
//
//  Created by kavi chen on 4/29/13.
//  Copyright (c) 2013 kavi chen. All rights reserved.
//

#import "KCViewController.h"
#import "GCDAsyncUdpSocket.h"
#define CLIENT_PORT 14551
#define CLIENT_IP @"127.0.0.1"
#define SERVER_PORT 14550

@interface KCViewController ()
  @property (nonatomic,strong) GCDAsyncUdpSocket *server_socket;

  @end

  @implementation KCViewController
  @synthesize server_socket = _server_socket;


  - (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  //    int port = LOCALHOST_PORT;
  self.server_socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
  NSLog(@"%@",self.server_socket);

  NSError *error = nil;
  if(![self.server_socket bindToPort:SERVER_PORT error:&error])
  {
    NSLog(@"%@",error);
  }

  [self.server_socket beginReceiving:&error];

}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
  mavlink_message_t msg;
  mavlink_status_t status;
  mavlink_sys_status_t sys_status;
  mavlink_local_position_ned_t local_position_ned;
  mavlink_attitude_t attitude;
  mavlink_global_position_int_t global_position_int_t;


  Byte *buf = (Byte *)[data bytes];
  NSInteger data_length = [data length];

  for (int i = 0; i < data_length; ++i) {
    //        printf("buf = %x\n",buf[i]);
    //        NSLog(@"%x",buf[i]);
    //        NSLog(@"%d",i);
  }

  //    *buf = [data bytes];
  unsigned int temp = 0;
  for (int i = 0; i< data_length; ++i) {
    int parse_success;
    parse_success = mavlink_parse_char(MAVLINK_COMM_0, buf[i], &msg, &status);
    temp = buf[i];
    if (parse_success) {
      switch (msg.msgid){
        case 0:

          NSLog(@" ***********Heart_Beat************");
          NSLog(@"*       msg.msgid = %3d           *\n",msg.msgid);
          NSLog(@"*       msg.seq = %3d             *\n",msg.seq);
          NSLog(@"*       msg.compid = %3d          *\n",msg.sysid);
          NSLog(@" *********************************\n");
          break;


        case 1:
          mavlink_msg_sys_status_decode(&msg,&sys_status);
          NSLog(@" *********System_Status***********\n");
          NSLog(@"*       battery voltage = %5d   *\n",sys_status.voltage_battery);
          NSLog(@"*       battery current = %3d     *\n",sys_status.current_battery);
          NSLog(@"*       battery remaining = %3d   *\n",sys_status.battery_remaining);
          NSLog(@" *********************************\n");
          break;

        case 32:
          mavlink_msg_local_position_ned_decode(&msg,&local_position_ned);

          NSLog(@" *********Local_Position**********\n");
          NSLog(@"*       X Position = %3f          *\n",local_position_ned.x);
          NSLog(@"*       Y Position = %3f          *\n",local_position_ned.y);
          NSLog(@"*       Z Position = %3f          *\n",local_position_ned.z);
          NSLog(@" *********************************\n");
          break;

        case 30:
          mavlink_msg_attitude_decode(&msg, &attitude);
          NSLog(@" *********Attitude****************\n");
          NSLog(@"*       roll = %3f                *\n",attitude.roll);
          NSLog(@"*       pitch = %3f               *\n",attitude.pitch);
          NSLog(@"*       yaw = %3f                 *\n",attitude.yaw);
          NSLog(@" *********************************\n");
          break;

        case 33:
          mavlink_msg_global_position_int_decode(&msg,&global_position_int_t);

          NSLog(@" *********Global_Position_Int******\n");
          NSLog(@"*       time_boot_ms = %d           *\n",global_position_int_t.time_boot_ms);
          NSLog(@"*       lat = %4d                   *\n",global_position_int_t.lat);
          NSLog(@"*       lon = %4d                   *\n",global_position_int_t.lon);
          NSLog(@"*       alt = %4d                   *\n",global_position_int_t.alt);
          NSLog(@"*       hdg = %4d                   *\n",global_position_int_t.hdg);
          NSLog(@" *********************************\n");
          break;
       // case 34:
          /*
           *mavlink_msg_global_position_int_decode();
           */


        default:
          NSLog(@"\n");
          continue;

      }


    }
  }
}
@end
