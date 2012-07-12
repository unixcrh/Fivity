//
//  StreamViewController.h
//  Fitivity
//
//  Shows the users discovery stream 
//
//  Created by Nathaniel Doe on 7/11/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "OpeningLogoViewController.h"

@class LoginViewController;

@interface StreamViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PFLogInViewControllerDelegate, OpeningLogoViewControllerDelegate> {
}

@property (nonatomic, retain) LoginViewController *loginView;

@end
