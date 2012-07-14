//
//  ChooseLocationViewController.h
//  Fitivity
//
//	Presents a list of locations from google places that are close to the user
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "PullToRefreshTableViewController.h"
#import "GooglePlacesConnection.h"

@protocol ChooseLocationViewControllerDelegate <NSObject>

- (void)userPickedLocation:(GooglePlacesObject *)place;

@end

@interface ChooseLocationViewController : PullToRefreshTableViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,  CLLocationManagerDelegate, GooglePlacesConnectionDelegate> {
	
	CLLocationManager		*locationManager;
	CLLocation				*currentLocation;
	
	NSMutableData			*responseData;
	NSMutableArray			*locations;
	NSMutableArray			*locationsFilterResults;
	NSString				*searchString;
	
	GooglePlacesConnection	*googlePlacesConnection;
}

-(void)buildSearchArrayFrom:(NSString *)matchString;

@property (nonatomic, getter = isResultsLoaded) BOOL resultsLoaded;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation        *currentLocation;

@property (nonatomic, retain) NSURLConnection   *urlConnection;
@property (nonatomic, retain) NSMutableData     *responseData;
@property (nonatomic, retain) NSMutableArray    *locations;
@property (nonatomic, retain) NSMutableArray    *locationsFilterResults;

@property (nonatomic, assign) id <ChooseLocationViewControllerDelegate> delegate;

@end
