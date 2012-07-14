//
//  AppDelegate.h
//  Fitivity
//
//  Created by Nathaniel Doe on 7/10/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class OpeningLogoViewController, FTabBarViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) OpeningLogoViewController *openingView;
@property (strong, nonatomic) FTabBarViewController *tabBarView;

@end
