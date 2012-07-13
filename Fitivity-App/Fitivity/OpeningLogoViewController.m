//
//  OpeningLogoViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/10/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "OpeningLogoViewController.h"

@interface OpeningLogoViewController ()

@end

@implementation OpeningLogoViewController

@synthesize logo;
@synthesize delegate;

#pragma mark -

- (void)finishedAnnimating {
	if ([self.delegate respondsToSelector:@selector(viewHasFinishedAnnimating:)]) {
		[self.delegate viewHasFinishedAnnimating:self];
	}
}

//Animate the logo to the place of the login view
- (void)annimateLogo {
	NSTimeInterval interval = 1.5;
	[UIView beginAnimations:@"logoMove" context:NULL];
	[UIView setAnimationDuration:interval];
	logo.frame = CGRectMake(50, 50, 225, 100);
	[UIView commitAnimations];
	[self performSelector:@selector(finishedAnnimating) withObject:nil afterDelay:interval];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(finishedAnnimating) withObject:nil afterDelay:1.5];
}

- (void)viewDidUnload {
    [self setLogo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
