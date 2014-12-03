#import <Foundation/Foundation.h>

/**
 * Klarna Inapp context
 */
@interface KIAContext : NSObject

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
 *  Whether user finished the registration process or not.
 *
 *  @return True if user finished the registration process, false if not.
 */
+ (bool)userFinishedRegistration;

@end
