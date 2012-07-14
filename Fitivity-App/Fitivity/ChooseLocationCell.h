//
//  ChooseLocationCell.h
//  Fitivity
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GooglePlacesObject.h"

@protocol ChooseLocationCellDelegate;

@interface ChooseLocationCell : UITableViewCell 

- (IBAction)showLocationOnmap:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) GooglePlacesObject *place;

@property (nonatomic, assign) id <ChooseLocationCellDelegate> delegate;

@end

@protocol ChooseLocationCellDelegate <NSObject>

- (void)openMapForCell:(ChooseLocationCell *)cell;

@end