#import "KIAContext.h"

@implementation KIAContext

static NSString *apiKey;

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

@end
