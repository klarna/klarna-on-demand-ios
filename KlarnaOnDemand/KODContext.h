#import <Foundation/Foundation.h>

#define KODDeviceLocale \
  [[NSBundle mainBundle] preferredLocalizations].firstObject

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
 *  Sets the preferred locale to use in the application.
 *
 *  @param preferredLocale Merchant's preferred locale for this application.
 */
+ (void)setPreferredLocale:(NSString *)preferredLocale;

/**
 *  Returns the preferred locale set using setPreferredLocale:.
 *
 *  @return Merchant's preferred locale for this application.
 */
+ (NSString *)getPreferredLocale;

@end
