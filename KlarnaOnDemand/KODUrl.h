#import <Foundation/Foundation.h>

@interface KODUrl : NSObject

+ (NSURL *)registrationUrl;

+ (NSURL *)preferencesUrlWithToken:(NSString *)token;

@end
