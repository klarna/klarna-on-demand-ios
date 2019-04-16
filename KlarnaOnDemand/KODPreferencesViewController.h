#import <UIKit/UIKit.h>
#import "KODWebViewController+Protected.h"

@class KODPreferencesViewController;

/**
 *  Defines the protocol for PreferencesViewController events.
 */
@protocol KODPreferencesViewControllerDelegate <NSObject>


/**
 *  Handler for preferences-page failure events.
 *
 *  @param controller Controller that initiated the event.
 *  @param dictionary The payload response.
 */
@optional
-(void) klarnaPreferencesFailed:(KODPreferencesViewController *)controller withPayload:(NSDictionary *)dictionary;

/**
 *  Handler for preferences-page failure navigation in WKWebView.
 *
 *  @param controller Controller that initiated the event.
 *  @param error object
 */
@optional
-(void) klarnaPreferencesFailed:(KODPreferencesViewController *)controller withError:(NSError *)error;

/**
 *  Handler for Klarna preferences-page close events.
 *  The event is raised when the user presses the 'Close' button on the upper-left corner of the view.
 *
 *  @param controller Controller that initiated the event.
 */
@optional
-(void) klarnaPreferencesClosed:(KODPreferencesViewController *)controller;

@end


/**
 *  Responsible for showing and modifying a user's payment methods.
 */
@interface KODPreferencesViewController : KODWebViewController

/**
 *  Initialize the Klarna preferences view-controller.
 *
 *  @param delegate Delegate which implements the KODPreferencesViewControllerDelegate protocol for handling preferences-page events.
 *  @param token    Token that uniquely identifies the user.
 *
 *  @return An initialized preferences view-controller, ready to be displayed.
 */
- (id)initWithDelegate:(id<KODPreferencesViewControllerDelegate>)delegate andToken:(NSString *)token;

@end
