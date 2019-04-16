#import <UIKit/UIKit.h>
#import "KODRegistrationResult.h"
#import "KODWebViewController+Protected.h"
#import "KODRegistrationSettings.h"

@class KODRegistrationViewController;

/**
 *  Defines the protocol for RegistrationViewController events.
 */
@protocol KODRegistrationViewControllerDelegate <NSObject>


/**
 *  Handler for registration finished event. 
 *  The event is fired when the user has finished registration and a token has been created.
 *  The token is required for making orders on behalf of the user.
 *
 *  @param controller Controller that initiated the event.
 *  @param registrationResult Registration result which holds the token that uniquely identifies the user.
 */
@required
- (void)klarnaRegistrationController:(KODRegistrationViewController *)controller finishedWithResult:(KODRegistrationResult *)registrationResult;

/**
 *  Handler for registration failure events.
 *
 *  @param controller Controller that initiated the event.
 *  @param dictionary The payload response.
 */
@optional
- (void)klarnaRegistrationFailed:(KODRegistrationViewController *)controller withPayload:(NSDictionary *)payload;

/**
 *  Handler for registration WKWebView failure events.
 *
 *  @param controller Controller that initiated the event.
 *  @param error object
 */
@optional
- (void)klarnaRegistrationFailed:(KODRegistrationViewController *)controller withError:(NSError *)error;

/**
 *  Handler for Klarna registration cancelled event. 
 *  The event is raised when the user presses the 'Cancel' button on the upper-left corner of the view.
 *
 *  @param controller Controller that initiated the event.
 */
@optional
- (void)klarnaRegistrationCancelled:(KODRegistrationViewController *)controller;

@end

/**
 *  Responsible for registering a new user and setting his Klarna payment method.
 */
@interface KODRegistrationViewController : KODWebViewController

/**
 *  Initialize the Klarna registration view-controller.
 *
 *  @param delegate Delegate which implements the KODRegistrationViewControllerDelegate protocol for handling registration events.
 *
 *  @return An initialized registration view-controller, ready to be displayed.
 */
- (id)initWithDelegate:(id<KODRegistrationViewControllerDelegate>)delegate;

/**
 *  Initialize the Klarna registration view-controller.
 *
 *  @param delegate Delegate which implements the KODRegistrationViewControllerDelegate protocol for handling registration events.
 *  @param registrationSettings customized settings for the registration view.
 *
 *  @return An initialized registration view-controller, ready to be displayed.
 */
- (id)initWithDelegate:(id<KODRegistrationViewControllerDelegate>)delegate andRegistrationSettings: (KODRegistrationSettings *) registrationSettings;

@end
