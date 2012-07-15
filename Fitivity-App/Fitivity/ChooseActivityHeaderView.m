//
//  ChooseActivityHeaderView.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/15/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "ChooseActivityHeaderView.h"

#define kLabelIndent		10
#define kImageBackIndent	30
#define kImageYIndent		20

@implementation ChooseActivityHeaderView

@synthesize openCloseIcon, titleLable, section;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title section:(NSInteger)section {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DarkerBlueBackplateTexture.png"]];
		self.userInteractionEnabled = YES;
		self.section = section;
		
		//Add the tap gesture to the header
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
		[self addGestureRecognizer:tapGesture];
		
		//Set up the possition of the label
		CGRect titleFrame = self.bounds;
		titleFrame.origin.x += kLabelIndent;
		titleFrame.size.width -= kLabelIndent;
		CGRectInset(titleFrame, 0.0, 5.0);
		titleLable = [[UILabel alloc] initWithFrame:titleFrame];
		titleLable.text = title;
		titleLable.font = [UIFont boldSystemFontOfSize:22];
		titleLable.textColor = [UIColor whiteColor];
		titleLable.backgroundColor = [UIColor clearColor];
		[self addSubview:titleLable];
		
		//Set up the possition of the button
		openCloseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(titleFrame.size.width - kImageBackIndent, titleFrame.origin.y + kImageYIndent, 31, 31)];
		[openCloseIcon setImage:[UIImage imageNamed:@"CategoryCellClosedIcon.png"]];
		[self addSubview:openCloseIcon];
		
		sectionOpen = NO;
    }
    return self;
}

- (IBAction)toggleOpen:(id)sender {
    [self toggleOpenWithUserAction:YES];
}

-(void)toggleOpenWithUserAction:(BOOL)userAction {
	sectionOpen = !sectionOpen;
	
	if (userAction) {
		if (sectionOpen) {
			if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
                [self.delegate sectionHeaderView:self sectionOpened:self.section];
            }
			[openCloseIcon setImage:[UIImage imageNamed:@"CategoryCellClosedIcon.png"]];
		}
		else {
			if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                [self.delegate sectionHeaderView:self sectionClosed:self.section];
            }
			[openCloseIcon setImage:[UIImage imageNamed:@"CategoryCellExpandedIcon.png"]];
		}
		
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
