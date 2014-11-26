//
//  ViewController.m
//  InappExample
//
//  Created by Yuval Netanel on 11/25/14.
//  Copyright (c) 2014 Yuval Netanel. All rights reserved.
//

#import "MainViewController.h"
#import "KIARegistrationViewController.h"

@implementation MainViewController

- (IBAction)onRegisterPressed:(id)sender {
  KIARegistrationViewController *registrationViewController = [[KIARegistrationViewController alloc] initWithDelegate:self];
  
  registrationViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                              target:self
                                                                                                              action:@selector(userDidCancelRegistration)];
  
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:registrationViewController];
  
  navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
  
  [self presentViewController:navigationController
                     animated:YES
                   completion:nil];
}


-(void)klarnaRegistrationFailed:(KIARegistrationViewController *)controller{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Web view failed to load" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
  [alert show];
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)userDidCancelRegistration {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
