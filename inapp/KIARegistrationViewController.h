#import <UIKit/UIKit.h>

@protocol KIARegistrationViewControllerDelegate;

/**
 *  Responsible for registering a new user with a Klarna payment method.
 */
@interface KIARegistrationViewController : UIViewController <UIWebViewDelegate>

/**
 *  Initialize Klarna registration view-controller.
 *
 *  @param delegate Delegate for handling registration events.
 *
 *  @return Initialized object.
 */
- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)delegate;

@end

/**
 *  Defines the protocol for RegistrationViewController events.
 */
@protocol KIARegistrationViewControllerDelegate <NSObject>

/**
 *  Handler for Klarna registration failed event.
 *
 *  @param controller Controller that initiated the event.
 */
-(void) klarnaRegistrationFailed:(KIARegistrationViewController *) controller;

/**
 *  Handler for Klarna registration cancelled event.
 *
 *  @param controller Controller that initiated the event.
 */
-(void) klarnaRegistrationCancelled:(KIARegistrationViewController *)controller;

@end