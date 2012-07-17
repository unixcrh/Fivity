//
//  ProposeActivityViewController.h
//  Fitivity
//
//  Created by Nathaniel Doe on 7/17/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProposeActivityViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *commentField;

@end
