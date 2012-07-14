//
//  FTabBarViewController.m
//  Fitivity
//
//  Created by Richard Ng 04/29/2012.
//  Copyright (c) 2012 Fitivity Inc. All rights reserved.
//

#import "FTabBarViewController.h"

@interface FTabBarViewController ()

@property(nonatomic, strong) UINavigationController *leftNavigationController;
@property(nonatomic, strong) UINavigationController *centerNavigationController;
@property(nonatomic, strong) UINavigationController *rightNavigationController;

@property(nonatomic, strong) UIViewController *leftRootViewController;
@property(nonatomic, strong) UIViewController *centerRootViewController;
@property(nonatomic, strong) UIViewController *rightRootViewController;

@property(nonatomic, strong) UINavigationController *displayedViewController;

// Presentation Management
-(void)informDelegateWillChange;
-(void)informDelegateDidChange;
-(void)updateDisplayedViewControllerTo:(UINavigationController *)displayedVC;
-(void)removeDisplayedViewControllerFromView;
-(void)insertDisplayedViewControllerIntoView;

@end

@implementation FTabBarViewController

@synthesize hostingView = _hostingView;
@synthesize tabBarBackplateView = _tabBarBackplateView;
@synthesize leftTabButton = _leftTabButton;
@synthesize centerTabButton = _centerTabButton;
@synthesize rightTabButton = _rightTabButton;

@synthesize delegate = _delegate;

@synthesize leftNavigationController = _leftNavigationController;
@synthesize centerNavigationController = _centerNavigationController;
@synthesize rightNavigationController = _rightNavigationController;

@synthesize leftRootViewController = _leftRootViewController;
@synthesize centerRootViewController = _centerRootViewController;
@synthesize rightRootViewController = _rightRootViewController;

@synthesize displayedViewController = _displayedViewController;
@synthesize loginView;

#pragma mark - OpeningLogoViewController Delegate

//	Once the logo is annimated into the place the login controller will be
//	we fade in the login view controller.
-(void)viewHasFinishedAnnimating:(OpeningLogoViewController *)view {	
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark - IBAction's

-(IBAction)leftTabButtonPushed:(id)sender {
	if (!self.isShowingLeftTab) {
	  [self showLeftTab];
	}
}

-(IBAction)centerTabButtonPushed:(id)sender {
	if (!self.isShowingCenterTab) {
	  [self showCenterTab];
	}
}

-(IBAction)rightTabButtonPushed:(id)sender {
	if (!self.isShowingRightTab) {
	  [self showRightTab];
	}
}

#pragma mark - Helper methods

-(BOOL)isShowingLeftTab {
	return (self.displayedViewController == self.leftNavigationController);
}

-(BOOL)isShowingCenterTab {
	return (self.displayedViewController == self.centerNavigationController);
}

-(BOOL)isShowingRightTab {
	return (self.displayedViewController == self.rightNavigationController);
}

-(void)showLeftTab {
	[self updateDisplayedViewControllerTo:self.leftNavigationController];
}

-(void)showRightTab {
	[self updateDisplayedViewControllerTo:self.rightNavigationController];
}

-(void)showCenterTab {
	[self updateDisplayedViewControllerTo:self.centerNavigationController];
}

- (void)login {
	if ([[FConfig instance] shouldLogIn]) {
		if (!loginView) {
			loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
		}
		[self presentModalViewController:loginView animated:YES];
	}
}

- (void)dismissChildView {
	[self dismissModalViewControllerAnimated:NO];
}


#pragma mark - View Lifecycle

-(id)initWithLeftRootViewController:(UIViewController *)leftRootVC centerRootViewController:(UIViewController *)centerRootViewController rightRootViewController:(UIViewController *)rightViewController {
  
	if ((self = [super initWithNibName:@"FTabBarViewController" bundle:nil])) {
		self.leftRootViewController = leftRootVC;
		self.centerRootViewController = centerRootViewController;
		self.rightRootViewController = rightViewController;
		
//		self.leftNavigationController = [UINavigationController fitNavigationControllerWithRootViewController:self.leftRootViewController];
//		self.centerNavigationController = [UINavigationController fitNavigationControllerWithRootViewController:self.centerRootViewController];
//		self.rightNavigationController = [UINavigationController fitNavigationControllerWithRootViewController:self.rightRootViewController];
//		^ fallback if iOS 5 skinning won't play nice
		
		self.leftNavigationController = [[UINavigationController  alloc] initWithRootViewController:self.leftRootViewController];
		self.centerNavigationController = [[UINavigationController alloc] initWithRootViewController:self.centerRootViewController];
		self.rightNavigationController = [[UINavigationController alloc] initWithRootViewController:self.rightRootViewController];
	}
	return self;
}

-(void)viewDidLoad {
	[super viewDidLoad];
	if (!self.displayedViewController) {
		[self updateDisplayedViewControllerTo:self.leftNavigationController];
	} else {
		[self insertDisplayedViewControllerIntoView];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	if ([PFUser currentUser] == nil) {
        [self login];
    } 
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissChildView) name:@"signedIn" object: nil];
}

-(void)viewWillUnload {
	[super viewWillUnload];
	[self removeDisplayedViewControllerFromView];
}

-(void)viewDidUnload {
	[super viewDidUnload];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	self.hostingView = nil;
	self.leftTabButton = nil;
	self.centerTabButton = nil;
	self.rightTabButton = nil;
	self.tabBarBackplateView = nil;
}

#pragma mark - Presentation Management

-(void)informDelegateWillChange {
	id<FTabBarViewControllerDelegate> delegate = [self delegate];
	if (delegate) {
		[delegate applicationTabBarViewControllerWillChangeTab:self];
	}
}

-(void)informDelegateDidChange {
	id<FTabBarViewControllerDelegate> delegate = [self delegate];
	if (delegate) {
		[delegate applicationTabBarViewControllerDidChangeTab:self];
	}
}

-(void)updateDisplayedViewControllerTo:(UINavigationController *)displayedVC {
	if (displayedVC != self.displayedViewController) {
		[self informDelegateWillChange];
		[self removeDisplayedViewControllerFromView];
		self.displayedViewController = displayedVC;
		[self insertDisplayedViewControllerIntoView];
		[self informDelegateDidChange];
	}
}

-(void)removeDisplayedViewControllerFromView {
	if (self.displayedViewController) {
		[self.displayedViewController willMoveToParentViewController:nil];
		[[self.displayedViewController view] removeFromSuperview];
		[self.displayedViewController removeFromParentViewController];
		self.displayedViewController = nil;
	}
}

-(void)insertDisplayedViewControllerIntoView {
	if (self.displayedViewController && self.hostingView) {
		[self addChildViewController:self.displayedViewController];
		[[self.displayedViewController view] setFrame:[self.hostingView bounds]];
		[self.hostingView addSubview:[self.displayedViewController view]];
		[self.displayedViewController didMoveToParentViewController:self];
	}
}

@end
