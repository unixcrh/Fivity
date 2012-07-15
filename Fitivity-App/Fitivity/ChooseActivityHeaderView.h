//
//  ChooseActivityHeaderView.h
//  Fitivity
//
//  Created by Nathaniel Doe on 7/15/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseActivityHeaderViewDelegate;

@interface ChooseActivityHeaderView : UIView {
	BOOL sectionOpen;
}


-(void)toggleOpenWithUserAction:(BOOL)userAction;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title section:(NSInteger)section;

@property (nonatomic, retain) UILabel *titleLable;
@property (nonatomic, retain) UIImageView *openCloseIcon;
@property (nonatomic, assign) NSInteger section;

@property (nonatomic, assign) id <ChooseActivityHeaderViewDelegate> delegate;

@end

@protocol ChooseActivityHeaderViewDelegate <NSObject>

@optional
-(void)sectionHeaderView:(ChooseActivityHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(ChooseActivityHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section;

@end