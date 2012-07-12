//
//  LoginViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/10/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "LoginViewController.h"

#define kFieldBuffer        10
#define kButtonBuffer       5
#define kButtonDiff         4

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - 

- (id)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //Set the positioning of each item 
    CGRect tempframe;
    self.logInView.logo.frame = CGRectMake(0, 0, 320, 100);
    
    tempframe = self.logInView.passwordField.frame;
    self.logInView.passwordField.frame = CGRectMake(tempframe.origin.x, tempframe.origin.y + kFieldBuffer, tempframe.size.width, tempframe.size.height);
    
    tempframe = self.logInView.logInButton.frame;
    self.logInView.logInButton.frame = CGRectMake(tempframe.origin.x, tempframe.origin.y + kFieldBuffer, (tempframe.size.width/2)-kButtonDiff, tempframe.size.height);
    self.logInView.signUpButton.frame = CGRectMake(tempframe.origin.x + tempframe.size.width/2 + kButtonBuffer, tempframe.origin.y + kFieldBuffer, (tempframe.size.width/2)-kButtonDiff, tempframe.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
	    
    //Update the logo
	self.logInView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FitivityLogo.png"]];
	self.signUpController.signUpView.logo = self.logInView.logo;
    
    //Set the backgrounds
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.signUpController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    //Hide any unncessary labels
    
    //Get references to the text fields 
    UITextField *userName = self.logInView.usernameField;
    UITextField *password = self.logInView.passwordField;
    UITextField *signUpUserName = self.signUpController.signUpView.usernameField;
    UITextField *signUpPassword = self.signUpController.signUpView.passwordField;
    UITextField *signUPEmail = self.signUpController.signUpView.emailField;
    
    //Configure the text fields
    userName.borderStyle = UITextBorderStyleRoundedRect;
    password.borderStyle = UITextBorderStyleRoundedRect;
    signUpUserName.borderStyle = UITextBorderStyleRoundedRect;
    signUpPassword.borderStyle = UITextBorderStyleRoundedRect;
    signUPEmail.borderStyle = UITextBorderStyleRoundedRect;
    
    userName.backgroundColor = [UIColor whiteColor];
    password.backgroundColor = [UIColor whiteColor];
    signUpUserName.backgroundColor = [UIColor whiteColor];
    signUpPassword.backgroundColor = [UIColor whiteColor];
    signUPEmail.backgroundColor = [UIColor whiteColor];
    
    userName.textColor = [UIColor blueColor]; //NEED TO CHANGE THIS TO THE RGB VALUE OF THE BACKGROUND
    password.textColor = [UIColor blueColor];
    signUpUserName.textColor = [UIColor blueColor];
    signUpPassword.textColor = [UIColor blueColor];
    signUPEmail.textColor = [UIColor blueColor];
    
}

@end
