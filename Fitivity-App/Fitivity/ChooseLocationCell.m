//
//  ChooseLocationCell.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/14/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "ChooseLocationCell.h"

@implementation ChooseLocationCell

@synthesize locationLabel;
@synthesize distanceLabel;
@synthesize mapButton;
@synthesize place;

@synthesize delegate;

- (IBAction)showLocationOnmap:(id)sender {
	if ([delegate respondsToSelector:@selector(openMapForCell:)]) {
		[delegate openMapForCell:self];
	}
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
