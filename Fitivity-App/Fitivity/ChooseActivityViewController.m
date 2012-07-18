//
//  ChooseActivityViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "ChooseActivityViewController.h"
#import "ChooseActivityCell.h"

#define kHeaderHeight	92
#define kRowHeight		45
#define kTagOffset		20

@interface ChooseActivityViewController ()

@end

@implementation ChooseActivityViewController

@synthesize activitiesTable, openSectionIndex;
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
				
				NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
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
					
					//Since we don't show any results at first (just headers) initialize the results array to have
					//as many empty arrays as there are categories. These arrays get updated in the header delegate methods.
					for (int i = 0; i < [categories count]; i++) {
						[resultsToShow addObject:[[NSMutableArray alloc] init]];
					}
					
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
	
	//Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
    NSInteger countOfRowsToInsert = [(NSMutableArray *)[categories objectAtIndex:section] count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
	
	/*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
	
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
	
    if (previousOpenSectionIndex != NSNotFound) {
		
		ChooseActivityHeaderView *previousOpenSection = (ChooseActivityHeaderView *)[self.activitiesTable viewWithTag:kTagOffset + previousOpenSectionIndex];
		[previousOpenSection setSectionOpen:NO];
        NSInteger countOfRowsToDelete = [(NSMutableArray *)[resultsToShow objectAtIndex:previousOpenSectionIndex] count];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
		[resultsToShow replaceObjectAtIndex:previousOpenSectionIndex withObject:[[NSMutableArray alloc] init]];
    }

	//Add the category to the results that will show
	[resultsToShow replaceObjectAtIndex:section withObject:[categories objectAtIndex:section]];
	[sectionHeaderView setSectionOpen:YES];
	
	// Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || section < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }

	[self.activitiesTable beginUpdates];
	[self.activitiesTable insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
	[self.activitiesTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
	[self.activitiesTable endUpdates];
	self.openSectionIndex = section;
}

-(void)sectionHeaderView:(ChooseActivityHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section {
	
	//Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view
	NSInteger countOfRowsToDelete = [(NSMutableArray *)[resultsToShow objectAtIndex:section] count];
	[resultsToShow replaceObjectAtIndex:section withObject:[[NSMutableArray alloc] init]];
	[sectionHeaderView setSectionOpen:NO];
	
	if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        [self.activitiesTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
	self.openSectionIndex = NSNotFound;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

	// Dequeue or create a cell of the appropriate type.
	ChooseActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChooseActivityCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
    }
	
	PFObject *activity = [(NSMutableArray *)[categories objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	cell.titleLabel.text = [activity objectForKey:@"name"];
		
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section { 
	NSString *title = @"";
	if ([categories count] > 0) {
		PFObject *firstObject = [(NSMutableArray *)[categories objectAtIndex:section] objectAtIndex:0];
		
		title = [firstObject objectForKey:@"category"];
	}
	
	ChooseActivityHeaderView *header = [[ChooseActivityHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.activitiesTable.bounds.size.width, kHeaderHeight) 
																		title:title section:section];
	[header setDelegate:self];
	[header setTag:kTagOffset + section];
	return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return kHeaderHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
	return [(NSMutableArray *)[resultsToShow objectAtIndex:section] count];
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
		categories = [[NSMutableArray alloc] init];
		resultsToShow = [[NSMutableArray alloc] init];
		openSectionIndex = NSNotFound;
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
