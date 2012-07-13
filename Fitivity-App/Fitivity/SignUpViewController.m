//
//  SignUpViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/12/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize nameField;
@synthesize userNameField;
@synthesize passwordField;
@synthesize reenterPasswordField;
@synthesize finishedButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

- (void)viewDidUnload {
    [self setNameField:nil];
    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [self setReenterPasswordField:nil];
    [self setFinishedButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
