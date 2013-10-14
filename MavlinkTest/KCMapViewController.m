//
//  KCMapViewController.m
//  MavlinkTest
//
//  Created by kavi chen on 13-8-12.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCMapViewController.h"
#import <MapKit/MapKit.h>

@interface KCMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation KCMapViewController
@synthesize mapView;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
