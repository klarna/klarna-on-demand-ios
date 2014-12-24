#import <Foundation/Foundation.h>

/**
 * Klarna On Demand context
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

@end
