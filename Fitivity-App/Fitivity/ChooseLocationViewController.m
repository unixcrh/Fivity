//
//  ChooseLocationViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "ChooseLocationViewController.h"
#import "SBJson.h"
#import "GTMNSString+URLArguments.h"
#import "GooglePlacesObject.h"

@interface ChooseLocationViewController ()

@end

@implementation ChooseLocationViewController

@synthesize resultsLoaded;
@synthesize locationManager;
@synthesize currentLocation;
@synthesize urlConnection;
@synthesize responseData;
@synthesize locations;
@synthesize locationsFilterResults;

#pragma mark - Helper Methods

-(void)buildSearchArrayFrom:(NSString *)matchString {
	NSString *upString = [matchString uppercaseString];
	
	locationsFilterResults = [[NSMutableArray alloc] init];
    
	for (GooglePlacesObject *location in locations) {
		if ([matchString length] == 0) {
			[locationsFilterResults addObject:location];
			continue;
		}
		
		NSRange range = [[location.name uppercaseString] rangeOfString:upString];
		
        if (range.location != NSNotFound) {
            
#ifdef DEBUG
			NSLog(@"Hit");
            
            NSLog(@"Location Name %@", location.name);
            NSLog(@"Search String %@", upString);
#endif
			
            [locationsFilterResults addObject:location];
        }
	}
	
	[tableView reloadData];
}

- (NSUInteger)arrayIndexFromIndexPath:(NSIndexPath *)path  {
    return path.row;
}

- (void)updateSearchString:(NSString*)aSearchString {
    searchString = [[NSString alloc]initWithString:aSearchString];
    
    //What places to search for
    NSString *searchLocations = [NSString stringWithFormat:@"%@|%@|%@|%@|%@", 
                                 kCampground, 
                                 kChurch,
                                 kGym,
                                 kPark,
                                 kStadium];
    
    
    [googlePlacesConnection getGoogleObjectsWithQuery:searchString 
                                       andCoordinates:CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude) 
                                             andTypes:searchLocations];
    
    [tableView reloadData];
}

//To handle filtering
- (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    [theSearchBar setShowsCancelButton:YES animated:YES];
    //Changed to YES to allow selection when in the middle of a search/filter
    tableView.allowsSelection   = YES;
    tableView.scrollEnabled     = YES;    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar {
    [theSearchBar setShowsCancelButton:NO animated:YES];
    [theSearchBar resignFirstResponder];
    tableView.allowsSelection   = YES;
    tableView.scrollEnabled     = YES;
    theSearchBar.text           = @"";
    
    [self updateSearchString:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    tableView.allowsSelection   = YES;
    tableView.scrollEnabled     = YES;
    
    [self updateSearchString:theSearchBar.text];
}

//Handle the filtering when user searches
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self buildSearchArrayFrom:searchText];
}

#pragma mark - PullToRefresh
- (void)reloadTableViewDataSource {
    [self setResultsLoaded:NO];
    
    [[self locationManager] startUpdatingLocation];
    
	[super performSelector:@selector(dataSourceDidFinishLoadingNewData) withObject:nil afterDelay:3.0];
}

- (void)dataSourceDidFinishLoadingNewData {
    [refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
    [super dataSourceDidFinishLoadingNewData];
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    //return [locations count];
    return [locationsFilterResults count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"LocationCell";
	
	// Dequeue or create a cell of the appropriate type.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Get the object to display and set the value in the cell.    
    GooglePlacesObject *place     = [[GooglePlacesObject alloc] init];
    
    //UPDATED from locations to locationFilter results
    place                       = [locationsFilterResults objectAtIndex:[indexPath row]];
    
    cell.textLabel.text                         = place.name;
    cell.textLabel.adjustsFontSizeToFitWidth    = YES;
	cell.textLabel.font                         = [UIFont systemFontOfSize:12.0];
	cell.textLabel.minimumFontSize              = 10;
	cell.textLabel.numberOfLines                = 4;
	cell.textLabel.lineBreakMode                = UILineBreakModeWordWrap;
    cell.textLabel.textColor                    = [UIColor colorWithRed:0.0 green:128.0/255.0 blue:0.0 alpha:1.0];
    cell.textLabel.textAlignment                = UITextAlignmentLeft;
    
    //You can use place.distanceInMilesString or place.distanceInFeetString.  
    //You can add logic that if distanceInMilesString starts with a 0. then use Feet otherwise use Miles.
    cell.detailTextLabel.text                   = [NSString stringWithFormat:@"%@ - Distance %@ miles", place.vicinity, place.distanceInMilesString];
    cell.detailTextLabel.textColor              = [UIColor darkGrayColor];
    cell.detailTextLabel.font                   = [UIFont systemFontOfSize:10.0];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
	
	//UPDATED from locations to locationFilterResults
	GooglePlacesObject *places = [locationsFilterResults objectAtIndex:selectedRowIndex.row];
		
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Location manager

/**
 Return a location manager -- create one if necessary.
 */
- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
		return locationManager;
	}
	
	locationManager = [[CLLocationManager alloc] init];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
	[locationManager setDelegate:self];
	
	return locationManager;
}


/**
 Conditionally enable the Add button:
 If the location manager is generating updates, then enable the button;
 If the location manager is failing, then disable the button.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if ([self isResultsLoaded]) {
		return;
	}
    
	[self setResultsLoaded:YES];
    
    currentLocation = newLocation;
    
    //What places to search for
    NSString *searchLocations = [NSString stringWithFormat:@"%@|%@|%@|%@|%@", 
                                 kCampground, 
                                 kChurch,
                                 kGym,
                                 kPark,
                                 kStadium];
    
    [googlePlacesConnection getGoogleObjects:CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude) 
                                    andTypes:searchLocations];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error  {
	
#ifdef DEBUG
    NSLog(@"%@", [error description]);
#endif
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Find You" 
													message:@"We could not find your location to find places around you. Try again when you are in a better service area" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

#pragma mark - NSURLConnections

//UPDATE - to handle filtering
- (void)googlePlacesConnection:(GooglePlacesConnection *)conn didFinishLoadingWithGooglePlacesObjects:(NSMutableArray *)objects  {
    
    if ([objects count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No matches found near this location" 
                                                        message:@"Try another place name or address" 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles: nil];
        [alert show];
    } 
	else {
        locations = objects;
        //UPDATED locationFilterResults for filtering later on
        locationsFilterResults = objects;
        [tableView reloadData];
    }
}

- (void) googlePlacesConnection:(GooglePlacesConnection *)conn didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error finding place - Try again" 
                                                    message:[error localizedDescription] 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];
}


#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.refreshHeaderView setLastRefreshDate:nil];    
    
    responseData = [[NSMutableData data] init];
    
    [[self locationManager] startUpdatingLocation];
    
    [tableView reloadData];
    [tableView setContentOffset:CGPointZero animated:NO];
    
    [searchBar setDelegate:self];
    
    googlePlacesConnection = [[GooglePlacesConnection alloc] initWithDelegate:self];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
