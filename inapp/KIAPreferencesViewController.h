#import <UIKit/UIKit.h>
#import "KIAWebViewController+Protected.h"

@class KIAPreferencesViewController;

/**
 *  Defines the protocol for PreferencesViewController events.
 */
@protocol KIAPreferencesViewControllerDelegate <NSObject>


/**
 *  Handler for preferences-page failure events.
 *
 *  @param controller Controller that initiated the event.
 */
@optional
-(void) klarnaPreferencesFailed:(KIAPreferencesViewController *)controller;

/**
 *  Handler for Klarna preferences-page close events.
 *  The event is raised when the user presses the 'Close' button on the upper-left corner of the view.
 *
 *  @param controller Controller that initiated the event.
 */
@optional
-(void) klarnaPreferencesClosed:(KIAPreferencesViewController *)controller;

@end


/**
 *  Responsible for showing and modifying a user's payment methods.
 */
@interface KIAPreferencesViewController : KIAWebViewController

/**
 *  Initialize the Klarna preferences view-controller.
 *
 *  @param delegate Delegate which implements the KIAPreferencesViewControllerDelegate protocol for handling preferences-page events.
 *  @param token    Token that uniquely identifies the user.
 *
 *  @return An initialized preferences view-controller, ready to be displayed.
 */
- (id)initWithDelegate:(id<KIAPreferencesViewControllerDelegate>)delegate andToken:(NSString *)token;

@end
