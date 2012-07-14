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

@protocol ChooseActivityViewControllerDelegate <NSObject>

- (void)userPickedActivity:(NSString *)activityName;

@end

@interface ChooseActivityViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	PFQuery *query;
	NSMutableArray *categoryArray, *categories;;
}

@property (weak, nonatomic) IBOutlet UITableView *activitiesTable;
@property (nonatomic, assign) id <ChooseActivityViewControllerDelegate> delegate;

@end
