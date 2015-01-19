#import "AFNetworking/AFNetworking.h"
#import "MainViewController.h"
#import "KODRegistrationViewController.h"
#import "KODPreferencesViewController.h"
#import "KODContext.h"
#import "KODOriginProof.h"

#define ALERT(str) [[[UIAlertView alloc] initWithTitle:@"Alert" message:str delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show]

NSString *const UserTokenKey = @"user_token";

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self initializeUIElements];
}

- (void)performPurchaseOfItemWithReference:(NSString *)reference usingProof:(NSString *)originProof {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  NSString *userToken = [self getUserToken];

  NSDictionary *params = @{
    @"origin_proof" : originProof,
    @"reference" :    reference,
    @"user_token" :   userToken
  };

  [manager POST:@"http://localhost:9292/pay" parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          // show QR Code for the movie.
          [self showQRView];
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          // Display an error.
          NSString *errorMessage = [NSString stringWithFormat:@"%@%@", @"Failed to purchase ticket - ", error.localizedDescription];
          ALERT(errorMessage);
        }
  ];
}

#pragma mark Button clicks

- (IBAction)onBuyPressed:(id)sender {
  // if a token has been previously created
  if([self hasUserToken]) {
    // create origin proof for order.
    NSString *originProof = [KODOriginProof generateWithAmount:9900 currency:@"SEK" userToken:[self getUserToken]];

    // send order request to app-server.
    [self performPurchaseOfItemWithReference:@"TCKT0001" usingProof:originProof];
  }
  else {
    // Create a new Klarna registration view-controller, initialized with MainViewController as event-handler.
    KODRegistrationViewController *registrationViewController = [[KODRegistrationViewController alloc] initWithDelegate:self];

    // Create navigation controller with Klarna registration view-controller as the root view controller.
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:registrationViewController];

    // Show navigation controller (in a modal presentation).
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
  }
}

- (IBAction)onChangePaymentPressed:(id)sender {
  // Create a new Klarna preferences view-controller, initialized with MainViewController as the event-handler, and the user token that was saved when the user completed the registration process.
  KODPreferencesViewController *preferencesViewController = [[KODPreferencesViewController alloc] initWithDelegate:self andToken:[self getUserToken]];

  // Create navigation controller with Klarna preferences view-controller as the root view controller.
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:preferencesViewController];

  // Show navigation controller (in a modal presentation).
  [self presentViewController:navigationController
                     animated:YES
                   completion:nil];
}

#pragma mark Registration delegate

- (void)klarnaRegistrationFailed:(KODRegistrationViewController *)controller {
  // You may also want to convey this failure to your user.
  // Dismiss Klarna registration view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)klarnaRegistrationCancelled:(KODRegistrationViewController *)controller {
  // Dismiss Klarna registration view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)klarnaRegistrationController:(KODRegistrationViewController *)controller finishedWithResult:(KODRegistrationResult *)registrationResult {
  // Dismiss Klarna registration view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
  
  // Save user token for future-use, in order to identify the user.
  [self saveUserToken:registrationResult.token];
  
  self.registerLabel.hidden = true;
  self.changePaymentButton.hidden = false;
}

#pragma mark Preferences delegate

- (void)klarnaPreferencesFailed:(KODPreferencesViewController *)controller {
  // Dismiss Klarna preferences view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)klarnaPreferencesClosed:(KODPreferencesViewController *)controller {
  // Dismiss Klarna preferences view-controller.
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark User token persistence

/**
 *  Save user token locally in device.
 *  You may want to save this token on your backend server.
 *
 *  @param token Token that uniquely identifies the user.
 */
- (void)saveUserToken:(NSString *)token {
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  [standardUserDefaults setValue:token forKey:UserTokenKey];
  [standardUserDefaults synchronize];
}

/**
 *  Get the token that was saved after registration finished.
 *
 *  @return A token that uniquely identifies the user, or nil of no token has been stored.
 
 */
- (NSString *)getUserToken {
  return [[NSUserDefaults standardUserDefaults] objectForKey:UserTokenKey];
}

- (bool)hasUserToken {
  return [self getUserToken] != nil;
}

# pragma mark UI behaviours

- (void)initializeUIElements {
  _buyButton.titleLabel.numberOfLines = 1;
  _buyButton.titleLabel.adjustsFontSizeToFitWidth = YES;
  _buyButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
  
  _registerLabel.hidden = [self hasUserToken];
  _changePaymentButton.hidden = ![self hasUserToken];
  
  [self hideQRView:nil];
}

- (IBAction)hideQRView:(id)sender {
  self.QRView.hidden = YES;
}

- (void)showQRView {
  self.QRView.hidden = NO;
}

@end
