#import <UIKit/UIKit.h>
#import "KIAToken.h"
#import "KIAWebViewController+Protected.h"

@class KIARegistrationViewController;


/**
 *  Defines the protocol for RegistrationViewController events.
 */
@protocol KIARegistrationViewControllerDelegate <NSObject>


/**
 *  Handler for registration finished event. 
 *  The event is fired when the user has finished registration and a token has been created.
 *  The token is required for making orders on behalf of the user.
 *
 *  @param controller Controller that initiated the event.
 *  @param token      Token that uniquely identifies the user.
 */
@required
- (void)klarnaRegistrationController:(KIARegistrationViewController *)controller finishedWithUserToken:(KIAToken *)token;

/**
 *  Handler for registration failure events.
 *
 *  @param controller Controller that initiated the event.
 */
@optional
- (void)klarnaRegistrationFailed:(KIARegistrationViewController *)controller;

/**
 *  Handler for Klarna registration cancelled event. 
 *  The event is raised when the user presses the 'Cancel' button on the upper-left corner of the view.
 *
 *  @param controller Controller that initiated the event.
 */
@optional
- (void)klarnaRegistrationCancelled:(KIARegistrationViewController *)controller;

@end

/**
 *  Responsible for registering a new user and setting his Klarna payment method.
 */
@interface KIARegistrationViewController : KIAWebViewController

/**
 *  Initialize the Klarna registration view-controller.
 *
 *  @param delegate Delegate which implements the KIARegistrationViewControllerDelegate protocol for handling registration events.
 *
 *  @return An initialized registration view-controller, ready to be displayed.
 */
- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)delegate;

@end
