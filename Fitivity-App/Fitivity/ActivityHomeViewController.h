//
//  ActivityHomeViewController.h
//  Fitivity
//
//	Main activity view that a user can create an activity from.
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChooseActivityViewController.h"
#import "ChooseLocationViewController.h"

@interface ActivityHomeViewController : UIViewController <ChooseActivityViewControllerDelegate, ChooseLocationViewControllerDelegate> {
	BOOL hasPickedBoth;
}

- (IBAction)chooseActivity:(id)sender;
- (IBAction)chooseLocation:(id)sender;

@end
