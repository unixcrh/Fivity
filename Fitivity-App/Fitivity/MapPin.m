//
//  MapPin.m
//  NeverForgotten
//
//  Created by Nathan Doe on 9/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

-(id)initWithCoordinates:(CLLocationCoordinate2D)location placeName: placeName description:description {
    
    self = [super init];
    if (self != nil) {
        coordinate = location;
        title = placeName;
        subtitle = description;
    }
    return self;
}

@end