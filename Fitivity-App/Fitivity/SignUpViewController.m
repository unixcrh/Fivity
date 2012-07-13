//
//  SignUpViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/12/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "SignUpViewController.h"

#define kTextFieldMoveDistance          100
#define kTextFieldAnimationDuration    0.3f

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize delegate;
@synthesize nameField;
@synthesize userNameField;
@synthesize passwordField;
@synthesize reenterPasswordField;
@synthesize finishedButton;
@synthesize resignButton;

#pragma mark - Helper Methods

//Make sure that the user information entered is valid
- (BOOL)inputIsValid {
    return YES;
}

#pragma mark - IBActions

- (IBAction)resignSignUp:(id)sender {
    [userNameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [reenterPasswordField resignFirstResponder];
    [nameField resignFirstResponder];
}

- (IBAction)cancelSignUp:(id)sender {
    [delegate userCancledSignUp:self];
}

- (IBAction)attemptSignUp:(id)sender {
    if ([self inputIsValid]) {
        [delegate userSignedUpSuccessfully:self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Up Error" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
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
}

- (void)viewDidUnload {
    [self setNameField:nil];
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
