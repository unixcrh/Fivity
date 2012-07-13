//
//  StreamViewController.m
//  Fitivity
//
//  Created by Nathaniel Doe on 7/11/12.
//  Copyright (c) 2012 Fitivity. All rights reserved.
//

#import "StreamViewController.h"
#import "LoginViewController.h"

@interface StreamViewController ()

@end

@implementation StreamViewController

@synthesize loginView;

#pragma mark - OpeningLogoViewController Delegate

//	Once the logo is annimated into the place the login controller will be
//	we fade in the login view controller.
-(void)viewHasFinishedAnnimating:(OpeningLogoViewController *)view {	
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Helper Methods

- (void)login {
	if ([[FConfig instance] shouldLogIn]) {
		if (!loginView) {
			loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
		}
		[self presentModalViewController:loginView animated:YES];
	}
}

#pragma mark - UITableViewDelegate 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;//CHANGE TO DYNAMIC 
}

#pragma mark - UITableViewDataSource 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Fitivity";
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([PFUser currentUser] == nil) {
        [self login];
    } 
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
