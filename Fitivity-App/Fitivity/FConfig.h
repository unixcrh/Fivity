// 
//  FConfig.h
//  Fitivity
// 
//	Configuration class to hold all cross class configuration variables
//
//  Created by Nathaniel Doe on 7/10/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FConfig : NSObject

// Get the singleton instance
+ (FConfig *)instance;

// Determine if the device has an internet connection
- (BOOL)connected;
- (BOOL)shouldLogIn;

- (NSString *)getParseAppID;
- (NSString *)getParseClientKey;
- (NSString *)getFacebookAppID;
- (NSString *)getGoogleAnalyticsID;
- (NSString *)getGooglePlacesAPIKey;

@end
