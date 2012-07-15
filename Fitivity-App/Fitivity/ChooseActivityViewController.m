//
//  ChooseActivityViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "ChooseActivityViewController.h"

#define kHeaderHeight	92

@interface ChooseActivityViewController ()

@end

@implementation ChooseActivityViewController

@synthesize activitiesTable;
@synthesize delegate;

#pragma mark - Helper Methods

- (void)attemptQuery {	
	
	@synchronized(self) { 
		
		if (!query) {
			query = [PFQuery queryWithClassName:@"Activity"];
			[query setCachePolicy:kPFCachePolicyNetworkElseCache]; //If the user isn't connected, it will look on the device disk for a cached version
			[query orderByAscending:@"category"];
			[query setLimit:200]; //Defaults to 100, just incase ones are added later on set to 200
			[query whereKeyExists:@"category"];
			[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
				
				if (!error) {
					NSString *lastCategory = @"";
					BOOL firstTry = YES;
					for (PFObject *o in objects) {

						if ([lastCategory isEqualToString:[o objectForKey:@"category"]]) {
							//If the object is in the same category as the last object then add it to the array
							[categoryArray addObject:o];
						}
						else {
							//Add the last category to the all categories array, get the new category, reset the array and add the next object
							//Don't want to add an empty array on the first attempt though.
							if (firstTry) {
								firstTry = NO;
							} 
							else {
								[categories addObject:categoryArray];
							}
							
							lastCategory = [o objectForKey:@"category"];
							categoryArray = nil;
							categoryArray = [[NSMutableArray alloc] initWithObjects: o, nil];
						}
					}
					[categories addObject:categoryArray];	//Need to add the last category
					categoryArray = nil;					//Clean up

					[activitiesTable reloadData];
				}
				else {
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Loading Error" message:@"Something went wrong when loading activities" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
					[alert show];
				}
			}];
		}
	}
}

#pragma mark - ChooseActivityHeaderView Delegate 

-(void)sectionHeaderView:(ChooseActivityHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section {
	
}

-(void)sectionHeaderView:(ChooseActivityHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section {
	
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	PFObject *activity = [(NSMutableArray *)[categories objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	cell.textLabel.text = [activity objectForKey:@"name"];
	
    return cell;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section { 
	NSString *title = @"";
	if ([categories count] > 0) {
		PFObject *firstObject = [(NSMutableArray *)[categories objectAtIndex:section] objectAtIndex:0];
		
		title = [firstObject objectForKey:@"category"];
	}
	
	ChooseActivityHeaderView *header = [[ChooseActivityHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.activitiesTable.bounds.size.width, kHeaderHeight) 
																		title:title section:section];
	[header setDelegate:self];
	return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return kHeaderHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;//[(NSMutableArray *)[categories objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [categories count];  
}

#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *selected = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
	
	if ([delegate respondsToSelector:@selector(userPickedActivity:)]) {
		[delegate userPickedActivity:selected];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        categoryArray = [[NSMutableArray alloc] init];
		categories = [[NSMutableArray alloc] init];
		[self attemptQuery];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [self setActivitiesTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
