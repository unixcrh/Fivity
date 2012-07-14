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
#import <CoreLocation/CoreLocation.h>

@interface StreamViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	
	NSMutableArray *fetchedQueryItems;
	NSMutableDictionary *fetchedQueryItemsByObjectID;
	
	CLLocationDistance queryRadius;
	PFGeoPoint *userGeoPoint;
	PFQuery *query;
}

@property (nonatomic, retain) IBOutlet UITableView *feedTable;

@end
