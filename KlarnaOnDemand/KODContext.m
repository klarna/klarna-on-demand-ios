#import "KODContext.h"

@implementation KODContext

static NSString *apiKey;
static NSString *preferredLocale;

+ (void)setApiKey:(NSString *)aApiKey {
    apiKey = aApiKey;
}

+ (NSString *)getApiKey {
    [self validateApiKey];
    return apiKey;
}

+ (void)validateApiKey {
    NSCAssert(apiKey.length > 0, @"You must set the API key first.");
}

+ (void)setPreferredLocale:(NSString *)aPreferredLocale {
    preferredLocale = aPreferredLocale;
}

+ (NSString *)getPreferredLocale {
    if (!preferredLocale) {
        preferredLocale = [[NSBundle mainBundle] preferredLocalizations].firstObject;
    }
    return preferredLocale;
}

@end
