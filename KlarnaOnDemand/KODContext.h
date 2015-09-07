#import <Foundation/Foundation.h>
@class UIColor;

/**
 * Manages the application-wide context for Klarna on Demand payments.
 */
@interface KODContext : NSObject

/**
 *  Sets the API key to use in following calls.
 *
 *  @param apiKey Merchant's public API key for this application.
 */
+ (void)setApiKey:(NSString *)apiKey;

/**
 *  Returns the API key set using setApiKey:.
 *
 *  @return Merchant's public API key for this application.
 */
+ (NSString *)getApiKey;

/**
 *  Returns the buttons' color set using setButtonColor:.
 *
 *  @return The color for all buttons in this application.
 */
+ (UIColor *)getButtonColor;

/**
 *  Sets the buttons' color in the application.
 *
 *  @param buttonColor The color for all buttons in this application.
 */
+ (void)setButtonColor:(UIColor *)buttonColor;

/**
 *  Returns the links' color set using setLinkColor:.
 *
 *  @return The color for all links in this application.
 */
+ (UIColor *)getLinkColor;

/**
 *  Sets the links' color in the application.
 *
 *  @param linkColor The color for all links in this application.
 */
+ (void)setLinkColor:(UIColor *)linkColor;

@end
