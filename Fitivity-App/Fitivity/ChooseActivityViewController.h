//
//  ChooseActivityViewController.h
//  Fitivity
//
//	Allows the user to pick which type of activity they are going to do
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "ChooseActivityHeaderView.h"

@protocol ChooseActivityViewControllerDelegate <NSObject>

- (void)userPickedActivity:(NSString *)activityName;

@end

@interface ChooseActivityViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ChooseActivityHeaderViewDelegate> {
	PFQuery *query;
	NSMutableArray *categories, *resultsToShow;
}

@property (weak, nonatomic) IBOutlet UITableView *activitiesTable;
@property (nonatomic, assign) NSInteger openSectionIndex;

@property (nonatomic, assign) id <ChooseActivityViewControllerDelegate> delegate;

@end
