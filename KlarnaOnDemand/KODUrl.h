#import <Foundation/Foundation.h>
#import "KODRegistrationSettings.h"

@interface KODUrl : NSObject

+ (NSURL *)registrationUrlWithSettings: (KODRegistrationSettings *) registrationSettings;
+ (NSURL *)preferencesUrlWithToken:(NSString *)token;

@end
