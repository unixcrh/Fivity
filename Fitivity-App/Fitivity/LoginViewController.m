//
//  LoginViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/10/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "LoginViewController.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
	    
    //Update the logo
	UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FitivityLogo.png"]];
    logoImage.frame = CGRectMake(0, 0, 320, 100);
	self.logInView.logo = logoImage;
	self.signUpController.signUpView.logo = logoImage;
    
    //Set the backgrounds
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.signUpController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
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
