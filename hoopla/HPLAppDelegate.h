//
//  HPLAppDelegate.h
//  hoopla
//
//  Created by Kaming Li on 3/1/14.
//  Copyright (c) 2014 Kaming Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPLMainViewController.h"
#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>

@interface HPLAppDelegate : UIResponder <UIApplicationDelegate, FYXServiceDelegate, FYXVisitDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;
@property (strong, nonatomic) HPLMainViewController *mainViewController;
@property (nonatomic) FYXVisitManager *visitManager;

@end
