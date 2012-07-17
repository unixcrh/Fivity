//
//  StreamViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/11/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "StreamViewController.h"
#import "DiscoverCell.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

#define kFeedLimit      20
#define kCellHeight     92.0f

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
    
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DiscoverCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
    }
    
    NSString *text = @"Basketball at YMCA";
    NSMutableAttributedString *attrStr = [NSMutableAttributedString attributedStringWithString:text];
    [attrStr setTextColor:[UIColor whiteColor]];
    [attrStr setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    
    // now we change the color of the activity & location
	[attrStr setTextColor:[UIColor blueColor] range:[text rangeOfString:@"Basketball"]];
	[attrStr setTextColor:[UIColor yellowColor] range:[text rangeOfString:@"YMCA"]];
    cell.activityLabel.attributedText = attrStr;
    
    [cell.imageView setImage:[UIImage imageNamed:@"FeedCellActiveGroupActivityIconImage.png"]];
    [cell.timeLabel setText:@"3:45 PM"];
    [cell.titleLabel setText:@"6 people are doing"];
    [cell.milesAwayLabel setText:@"3.4 Miles"];
    
//	PFObject *temp = [fetchedQueryItems objectAtIndex:indexPath.row];
//	cell.textLabel.text = [temp objectId];
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kCellHeight;
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
