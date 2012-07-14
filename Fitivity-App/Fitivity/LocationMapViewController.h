//
//  LocationMapViewController.h
//  Fitivity
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "GooglePlacesObject.h"

@interface LocationMapViewController : UIViewController <MKMapViewDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil place:(GooglePlacesObject *)thePlace;

@property (nonatomic, retain) GooglePlacesObject *place;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
