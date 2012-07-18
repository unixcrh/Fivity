//
//  SignUpViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/12/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "SignUpViewController.h"
#import "NSRegularExpression+FITUtilities.h"
#import "NSError+FITParseUtilities.h"

#define kTextFieldMoveDistance          100
#define kTextFieldAnimationDuration    0.3f

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize delegate;
@synthesize emailField;
@synthesize userNameField;
@synthesize passwordField;
@synthesize reenterPasswordField;
@synthesize finishedButton;
@synthesize resignButton;

#pragma mark - Helper Methods

//Make sure that the user information entered is valid
- (BOOL)inputIsValid {
	NSString *emailText = self.emailField.text;
	__block BOOL emailValid = [emailExpression stringIsConformant:self.emailField.text];
	
	__block BOOL userValid = [userNameExpression stringIsConformant:self.userNameField.text];
	
	NSString *password1Text = self.passwordField.text;
	NSString *password2Text = self.reenterPasswordField.text;
	BOOL password1Valid = (password1Text && ([password1Text length] > 0));
	BOOL password2Valid = (password2Text && ([password2Text length] > 0));
	BOOL bothPasswordsValid = NO;
	
	
	//Check name 
	if (emailValid) {
		PFQuery *query = [PFQuery queryWithClassName:@"User"];
		[query whereKey:@"email" equalTo:self.emailField.text];
		[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
			if (!error) {
				if ([objects count] != 0) {
					errorMessage = @"There is already an account with that username.";
					emailValid = NO;
				}
			}
		}];

	}
	else {
		errorMessage = @"The email address you entered was not valid.";
		emailValid = NO;
	}
	
	//Check username
	if (userValid) {
		PFQuery *query = [PFQuery queryWithClassName:@"User"];
		[query whereKey:@"username" equalTo:self.userNameField.text];
		[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
			if (!error) {
				if ([objects count] != 0) {
					errorMessage = @"The username you entered is already taken.";
					userValid = NO;
				}
			}
		}];
	}
	else {
		errorMessage = @"The username you entered was not valid.";
		userValid = NO;
	}
	
	//Check password
	if (password1Valid && password2Valid) {
		if ([password1Text isEqualToString:password2Text]) {
			bothPasswordsValid = YES;
		}
		else {
			errorMessage = @"The passwords you entered do not match.";
			bothPasswordsValid = NO;
		}
	}
	else {
		errorMessage = @"You must have a password more than 5 characters!";
		bothPasswordsValid = NO;
	}
	
	return emailValid && userValid && bothPasswordsValid;
}

//After input has been validated, we can now sign the user up
- (void)signUp {
	PFUser *attemptedUser = [[PFUser alloc] init];
	[attemptedUser setUsername:[self.userNameField.text lowercaseString]];
	[attemptedUser setPassword:self.passwordField.text];
	[attemptedUser setEmail:self.emailField.text];
	[attemptedUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (error || !succeeded) {
			errorMessage = @"An unknown registration error occurred.";
			if (error) {
				errorMessage = [error userFriendlyParseErrorDescription:YES];
			}
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Succceded!" message:@"Welcome to Fitivity! We're glad to have you." delegate:self cancelButtonTitle:@"Let's Go!" otherButtonTitles: nil];
			[alert show];
			[self.delegate userSignedUpSuccessfully:self];
		}
	}];
}

#pragma mark - IBActions

- (IBAction)resignSignUp:(id)sender {
    [userNameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [reenterPasswordField resignFirstResponder];
    [emailField resignFirstResponder];
}

- (IBAction)cancelSignUp:(id)sender {
    [delegate userCancledSignUp:self];
}

- (IBAction)attemptSignUp:(id)sender {
    
	@synchronized(self) {
		if ([self inputIsValid]) {
			[self signUp];
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Up Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
		}
	}
}

#pragma mark - UITextField Delegate 

//Move the text fields up so that the keyboard does not cover them
- (void) animateTextField:(UITextField*)textField Up:(BOOL)up {
    
    int movement = (up ? -kTextFieldMoveDistance : kTextFieldMoveDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: kTextFieldAnimationDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self animateTextField:textField Up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self animateTextField:textField Up:NO];
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
	userNameExpression = [[NSRegularExpression alloc] initWithPattern:@"[a-zA-Z0-9]+" options:NSRegularExpressionCaseInsensitive error:nil];
	emailExpression = [[NSRegularExpression alloc] initWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:NSRegularExpressionCaseInsensitive error:nil];
}

- (void)viewDidUnload {
    [self setEmailField:nil];
    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [self setReenterPasswordField:nil];
    [self setFinishedButton:nil];
    [self setResignButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
