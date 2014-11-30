#import "MainViewController.h"
#import "KIARegistrationViewController.h"

@implementation MainViewController

- (IBAction)onRegisterPressed:(id)sender {
  
  // Create a new Klarna registration view-controller, initialized with MainViewController as event-handler.
  KIARegistrationViewController *registrationViewController = [[KIARegistrationViewController alloc] initWithDelegate:self];
  
  // Create navigation controller with Klarna registration view-controller as the root view controller.
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:registrationViewController];
  
  // Show navigation controller (in a modal presentation).
  [self presentViewController:navigationController
                     animated:YES
                   completion:nil];
}


-(void)klarnaRegistrationFailed:(KIARegistrationViewController *)controller{
  // You may also want to convey this failure to your user.
  // Dismiss Klarna registration view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)klarnaRegistrationCancelled:(KIARegistrationViewController *)controller {
  
  // Dismiss Klarna registration view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
