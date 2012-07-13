//
//  LoginViewViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/12/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userNameField;
@synthesize passwordField;
@synthesize signUpButton;
@synthesize signInButton;
@synthesize facebookSignUpButton;

#pragma mark - IBActions

- (IBAction)signUp:(id)sender {
	SignUpViewController *signUpView = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
	[self presentModalViewController:signUpView animated:YES];
}

- (IBAction)signIn:(id)sender {
}

- (IBAction)signInWithFacebook:(id)sender {
}

#pragma mark - UITextField Delegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	
}

#pragma mark - view lifecycle

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
	[signInButton setImage:[UIImage imageNamed:@"LoginButtonPushed.png"] forState:UIControlStateHighlighted];
	[signUpButton setImage:[UIImage imageNamed:@"RegistreButton.png"] forState:UIControlStateHighlighted];
	 
}

- (void)viewDidUnload {
	[self setUserNameField:nil];
	[self setPasswordField:nil];
	[self setSignUpButton:nil];
	[self setSignInButton:nil];
	[self setFacebookSignUpButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
