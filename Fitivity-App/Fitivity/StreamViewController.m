//
//  StreamViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/11/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "StreamViewController.h"

#define kFeedLimit	20

@interface StreamViewController ()

@end

@implementation StreamViewController

@synthesize feedTable;

#pragma mark - Helper Methods

- (void)handleQueryResults:(NSArray *)theResults {
	for (PFObject *object in theResults) {
		[fetchedQueryItems addObject:object];
		[fetchedQueryItemsByObjectID setObject:object forKey:[object objectId]];
	}
	if ([fetchedQueryItems count] > 0) {
		[feedTable reloadData];
	}
}

- (void)attemptFeedQuery {
	@synchronized(self) {
		if (!query) {
			query = [[PFQuery alloc] initWithClassName:@"FitivityFeedEntryItem"];
			[query orderByDescending:@"updatedAt"];
			[query whereKey:@"FitivityFeedEntryGeographicLocation" nearGeoPoint:userGeoPoint withinMiles:queryRadius];
			[query setLimit:kFeedLimit];
			[query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
				if (error) {
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Error" message:@"Could not load your feed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
					[alert show];
				}
				else {
					[self handleQueryResults:results];
				}
			}];
		}
	}
}

#pragma mark - UITableViewDelegate 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//	PFObject *temp = [fetchedQueryItems objectAtIndex:indexPath.row];
//	cell.textLabel.text = [temp objectId];
	
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;//CHANGE TO DYNAMIC 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1; 
}

#pragma mark - UITableViewDataSource 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.tabBarItem.image = [UIImage imageNamed:@"ApplicationFeedTabNormalPushed.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
		
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	fetchedQueryItems = [[NSMutableArray alloc] init];
	fetchedQueryItemsByObjectID = [[NSMutableDictionary alloc] init];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
