//
//  FTabBarViewController.h
//  Fitivity
//
//  Created by Richard Ng 04/29/2012.
//  Copyright (c) 2012 Fitivity Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "OpeningLogoViewController.h"
#import "LoginViewController.h"

@class FTabBarViewController;

@protocol FTabBarViewControllerDelegate <NSObject>

-(void)applicationTabBarViewControllerWillChangeTab:(FTabBarViewController *)applicationTabBarViewController;
-(void)applicationTabBarViewControllerDidChangeTab:(FTabBarViewController *)applicationTabBarViewController;

@end

@interface FTabBarViewController : UIViewController <OpeningLogoViewControllerDelegate>


-(IBAction)leftTabButtonPushed:(id)sender;
-(IBAction)centerTabButtonPushed:(id)sender;
-(IBAction)rightTabButtonPushed:(id)sender;

-(BOOL)isShowingLeftTab;
-(BOOL)isShowingCenterTab;
-(BOOL)isShowingRightTab;

-(void)showLeftTab;
-(void)showRightTab;
-(void)showCenterTab;

-(UINavigationController *)leftNavigationController;
-(UINavigationController *)centerNavigationController;
-(UINavigationController *)rightNavigationController;

-(UIViewController *)leftRootViewController;
-(UIViewController *)centerRootViewController;
-(UIViewController *)rightRootViewController;

-(id)initWithLeftRootViewController:(UIViewController *)leftRootVC centerRootViewController:(UIViewController *)centerRootViewController rightRootViewController:(UIViewController *)rightViewController;

@property (nonatomic, strong) IBOutlet UIView *hostingView;
@property (nonatomic, strong) IBOutlet UIImageView *tabBarBackplateView;
@property (nonatomic, strong) IBOutlet UIButton *leftTabButton;
@property (nonatomic, strong) IBOutlet UIButton *centerTabButton;
@property (nonatomic, strong) IBOutlet UIButton *rightTabButton;
@property (nonatomic, retain) LoginViewController *loginView;

@property (nonatomic, weak) IBOutlet id<FTabBarViewControllerDelegate> delegate;

@end
