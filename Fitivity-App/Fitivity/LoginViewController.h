//
//  LoginViewViewController.h
//  Fitivity
//
//  Created by Nathaniel Doe on 7/12/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

- (IBAction)signUp:(id)sender;
- (IBAction)signIn:(id)sender;
- (IBAction)signInWithFacebook:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookSignUpButton;

@end
