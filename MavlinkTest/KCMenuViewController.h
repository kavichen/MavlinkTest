//
//  KCMenuViewController.h
//  MavlinkTest
//
//  Created by kavi chen on 13-11-5.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RESideMenu.h>
@interface KCMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RESideMenuDelegate>

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end
