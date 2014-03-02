//
//  HPLMainViewController.h
//  hoopla
//
//  Created by Kaming Li on 3/2/14.
//  Copyright (c) 2014 Kaming Li. All rights reserved.
//

#import "HPLViewController.h"
#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>

@interface HPLMainViewController : HPLViewController <FYXVisitDelegate>
@property (nonatomic, strong, readonly) UIButton *playButton;
@property (nonatomic, strong, readonly) UIButton *missionOneButton;
@property (nonatomic, strong, readonly) UIButton *missionTwoButton;
@property (nonatomic, strong, readonly) UIButton *shareButton;
@property (nonatomic) FYXVisitManager *visitManager;
@end
