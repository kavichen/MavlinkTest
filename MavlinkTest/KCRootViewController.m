//
//  KCRootViewController.m
//  MavlinkTest
//
//  Created by kavi chen on 13-11-5.
//  Copyright (c) 2013年 kavi chen. All rights reserved.
//

#import "KCRootViewController.h"
#import "KCMenuViewController.h"

@interface KCRootViewController ()

@end

@implementation KCRootViewController

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    self.panGestureEnabled = NO;
    self.delegate = (KCMenuViewController  *)self.menuViewController;
}


@end
