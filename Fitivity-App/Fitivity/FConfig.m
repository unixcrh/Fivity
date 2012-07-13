//
//  FConfig.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/10/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "FConfig.h"
#import "Reachability.h"

#define kParseAppID			@"MmUj6HxQcfLSOUs31lG7uNVx9sl5dZR6gv0FqGHq"
#define kParseClientKey		@"krpZsVM2UrU71NCxDbdAmbEMq1EXdpygkl251Wjl"
#define kFacebookAppID		@"109034229168990"	//CHANGE TO ACTUAL APP ID - THIS IS JUST A TEMP WORKING ONE
#define kGoogleAnalyticsID	@""

@implementation FConfig

static FConfig *instance;

#pragma mark - Singleton Instance

+ (FConfig *)instance {
	@synchronized([FConfig class]) {
		if (instance == nil) {
			instance = [[FConfig alloc] init];
		}
	}
	return instance;
}

#pragma mark - BOOL methods

- (BOOL)connected {
	//return NO; // force for offline testing
	Reachability *hostReach = [Reachability reachabilityForInternetConnection];	
	NetworkStatus netStatus = [hostReach currentReachabilityStatus];	
    return !(netStatus == NotReachable);
}

- (BOOL)shouldLogIn {
	return YES;
}

#pragma mark - NSString methods 

- (NSString *)getParseAppID {
	return kParseAppID;
}

- (NSString *)getParseClientKey {
	return kParseClientKey;
}

- (NSString *)getFacebookAppID {
	return kFacebookAppID;
}

- (NSString *)getGoogleAnalyticsID {
	return kGoogleAnalyticsID;
}

@end
