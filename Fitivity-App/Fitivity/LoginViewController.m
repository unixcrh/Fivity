//
//  LoginViewViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/12/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "NSError+FITParseUtilities.h"

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
	@synchronized(self) {
		NSString *username = [self.userNameField text];
		NSString *password = [self.passwordField text];
		if (username && password) {
			if ([username length] > 0 && [password length] > 0) {
				[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
					if (error || !user) {
						NSString *errorMessage = @"Could not login due to unknown error.";
						if (error) {
							errorMessage = [error userFriendlyParseErrorDescription:YES];
						}
						UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
						[alert show];
					}
					else {
						//Logged in successfully 
						[self dismissModalViewControllerAnimated:YES];
					}
				}];
			}
		}
	}
}

- (IBAction)signInWithFacebook:(id)sender {
	@synchronized(self) {
		[PFFacebookUtils logInWithPermissions:[[NSArray alloc] init] block:^(PFUser *user, NSError *error){
			if (error || !user) {
				NSString *errorMessage = @"Couldn't login due to unknown error.";
				if (error) {
					errorMessage = [error userFriendlyParseErrorDescription:YES];
				}
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			}
		 else {
			 //Logged in successfully 
			 [self dismissModalViewControllerAnimated:YES];
		 }
		}];

	}
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
