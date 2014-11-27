#import <Foundation/Foundation.h>


@interface KIAContext : NSObject

/**
 *  Sets api key parameter.
 *
 *  @param apiKey Merchant's public api key for this application.
 */
+ (void)setApiKey:(NSString *)apiKey;

/**
 *  Gets api key parameter.
 *
 *  @return Merchant's public api key for this application.
 */
+ (NSString *)getApiKey;

@end
