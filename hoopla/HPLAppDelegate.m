//
//  HPLAppDelegate.m
//  hoopla
//
//  Created by Kaming Li on 3/1/14.
//  Copyright (c) 2014 Kaming Li. All rights reserved.
//

#import "HPLAppDelegate.h"

@implementation HPLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FYX setAppId:@"491ca5c9361c1fe0a4445cd830881febbcaad9e69e8cddc84e0cd45a695f2192"
		appSecret:@"9b119dcad8083f94f32c8611d336e48719b8cfffb6a8b78368731a8968f4a14c"
	  callbackUrl:@"your-callback-url"];
	
	[FYX startService:self];
    
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.mainViewController = [[HPLMainViewController alloc] initWithNibName:nil bundle:nil];
	self.nav = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
	self.nav.navigationBarHidden = YES;
	self.window.rootViewController = self.nav;
    [self.window makeKeyAndVisible];
	
	return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Gimbal

- (void)serviceStarted
{
	// this will be invoked if the service has successfully started
	// bluetooth scanning will be started at this point.
	NSLog(@"FYX Service Successfully Started");
	
	self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
    [self.visitManager start];
}

- (void)startServiceFailed:(NSError *)error
{
	// this will be called if the service has failed to start
	NSLog(@"%@", error);
}

- (void)didArrive:(FYXVisit *)visit;
{
	// this will be invoked when an authorized transmitter is sighted for the first time
	NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
	// this will be invoked when an authorized transmitter is sighted during an on-going visit
	NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
	NSLog(@"Beacon name:%@", visit.transmitter.name);
	NSLog(@"RSSI: %f", RSSI.floatValue);
}

- (void)didDepart:(FYXVisit *)visit;
{
	// this will be invoked when an authorized transmitter has not been sighted for some time
	NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
	NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}

@end
