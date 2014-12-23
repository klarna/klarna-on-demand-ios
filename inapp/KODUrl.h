#import <Foundation/Foundation.h>

@interface KIAUrl : NSObject

+ (NSURL *)registrationUrl;

+ (NSURL *)preferencesUrlWithToken:(NSString *)token;

@end
