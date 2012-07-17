//
//  DiscoverCell.h
//  Fitivity
//
//  Created by Nathaniel Doe on 7/16/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OHAttributedLabel.h"

@interface DiscoverCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *milesAwayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@end
