#import <UIKit/UIKit.h>

@protocol KIARegistrationViewControllerDelegate;

/**
 *  Responsible for registering a new user and setting his Klarna payment method.
 */
@interface KIARegistrationViewController : UIViewController <UIWebViewDelegate>

/**
 *  Initialize the Klarna registration view-controller.
 *
 *  @param delegate Delegate which implement KIARegistrationViewControllerDelegate protocol for handling registration events.
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
 *  Handler for registration failure events.
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