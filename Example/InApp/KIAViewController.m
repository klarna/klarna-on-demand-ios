//
//  KIAViewController.m
//  InApp
//
//  Created by Guy Rozen on 11/17/2014.
//  Copyright (c) 2014 Guy Rozen. All rights reserved.
//

#import "KIAViewController.h"
#import "KIARegistrationViewController.h"

@interface KIAViewController ()

@end

@implementation KIAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)onRegistarPressed:(id)sender {
    KIARegistrationViewController *registrationViewController = [[KIARegistrationViewController alloc] initWithDelegate:self];
    [self presentViewController:registrationViewController
                       animated:YES
                     completion:nil];
}

@end
