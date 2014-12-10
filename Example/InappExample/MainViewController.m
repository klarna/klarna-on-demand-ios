#import "MainViewController.h"
#import "KIARegistrationViewController.h"
#import "KIAPreferencesViewController.h"
#import "KIAContext.h"

#define ALERT(str) [[[UIAlertView alloc] initWithTitle:@"Alert" message:str delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show]

#define USER_TOKEN_KEY @"user_token"

@implementation MainViewController

-(void)viewDidLoad {
  [self updateButtonVisibility];
}

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

- (IBAction)onPreferencesPressed:(id)sender {
  
  // Create a new Klarna preferences view-controller, initialized with MainViewController as event-handler, and a user token that was saved after user has finished registering.
  KIAPreferencesViewController *preferencesViewController = [[KIAPreferencesViewController alloc] initWithDelegate:self andToken:[self getUserToken]];
  
  // Create navigation controller with Klarna preferences view-controller as the root view controller.
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:preferencesViewController];
  
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

-(void)klarnaRegistrationController:(KIARegistrationViewController *)controller didFinishWithUserToken:(KIAToken *) userToken {
  
  // Dismiss Klarna registration view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
  
  // Save user token for future-use, in order to identify the user.
  [self saveUserToken:userToken.token];
  
  [self updateButtonVisibility];
}

-(void)klarnaPreferencesFailed:(KIAPreferencesViewController *)controller {
  
  // Dismiss Klarna preferences view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)klarnaPreferencesCancelled:(KIAPreferencesViewController *)controller {
  
  // Dismiss Klarna preferences view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onBuyPressed:(id)sender {
  
  NSString *message = [NSString stringWithFormat:@"Order sent to app-server with token: %@", [self getUserToken]];
  ALERT(message);
}

/**
 *  Save user token locally in device.
 *  You may want to save this token on you backend server.
 *
 *  @param token Token that uniquely identifies the user.
 */
- (void) saveUserToken: (NSString *) token {
  
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  [standardUserDefaults setValue:token forKey:USER_TOKEN_KEY];
  [standardUserDefaults synchronize];
}

/**
 *  Get token that was saved after registration finished.
 *
 *  @return Token that uniquely identifies the user. Otherwise, returns nil.
 
 */
- (NSString *) getUserToken {
  
  return [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN_KEY];
}

- (bool) hasUserToken {
  
  return [self getUserToken] != nil;
}

- (void) updateButtonVisibility {
  
  _registerButton.hidden = [self hasUserToken];
  _buyButton.hidden = ![self hasUserToken];
  _preferencesButton.hidden = ![self hasUserToken];
}
@end
