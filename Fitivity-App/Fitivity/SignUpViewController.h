//
//  SignUpViewController.h
//  Fitivity
//
//  Created by Nathaniel Doe on 7/12/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol SignUpViewControllerDelegate;

@interface SignUpViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    NSString *errorMessage;
	
	PFQuery *activeUserNameQuery;
	PFQuery *activeEMailQuery;
	
	NSRegularExpression *userNameExpression, *emailExpression;
}

- (IBAction)resignSignUp:(id)sender;
- (IBAction)cancelSignUp:(id)sender;
- (IBAction)attemptSignUp:(id)sender;

@property (nonatomic, assign) id<SignUpViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *reenterPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *finishedButton;
@property (weak, nonatomic) IBOutlet UIButton *resignButton;

@end

@protocol SignUpViewControllerDelegate <NSObject>

-(void)userCancledSignUp:(SignUpViewController *)view;
-(void)userSignedUpSuccessfully:(SignUpViewController *)view;

@end