//
//  AppDelegate.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/10/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "AppDelegate.h"
#import "FTabBarViewController.h"
#import "OpeningLogoViewController.h"
#import "StreamViewController.h"
#import "ActivityHomeViewController.h"
#import "UserProfileViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize openingView = _openingView;
@synthesize tabBarView = _tabBarView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setAutoresizesSubviews:YES];
    
	//Initialize the main view controllers
	self.openingView = [[OpeningLogoViewController alloc] initWithNibName:@"OpeningLogoViewController" bundle:nil];
	StreamViewController *streamView = [[StreamViewController alloc] initWithNibName:@"StreamViewController" bundle:nil];
	ActivityHomeViewController *activity = [[ActivityHomeViewController alloc] initWithNibName:@"ActivityHomeViewController" bundle:nil];
	UserProfileViewController *profile = [[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:nil];
	self.tabBarView = [[FTabBarViewController alloc] initWithLeftRootViewController:streamView centerRootViewController:activity rightRootViewController:profile];
	
	[self.openingView setDelegate:self.tabBarView];
	
	//Set up parse credentials 
	[Parse setApplicationId:[[FConfig instance] getParseAppID] clientKey:[[FConfig instance] getParseClientKey]];
	[PFFacebookUtils initializeWithApplicationId:[[FConfig instance] getFacebookAppID]];
	
	self.window.rootViewController = self.tabBarView;
	self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	
	//Present the opening view
	[self.tabBarView presentModalViewController:self.openingView animated:NO];
	
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	return [PFFacebookUtils handleOpenURL:url]; 
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
