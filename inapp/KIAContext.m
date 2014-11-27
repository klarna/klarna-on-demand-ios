#import "KIAContext.h"

@implementation KIAContext

static NSString *apiKey;

+ (void)setApiKey:(NSString *)aApiKey {
    apiKey = aApiKey;
}

+ (NSString *)getApiKey {
    [self validateApiKeySet];
    return apiKey;
}

+ (void)validateApiKeySet {
    NSCAssert(apiKey != nil && ![apiKey isEqualToString:@""], @"You must set the API key first!");
}

@end
