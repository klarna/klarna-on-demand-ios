#import "KIAContext.h"

@implementation KIAContext

static NSString *apiKey;

+ (void)setApiKey:(NSString *)aApiKey {
    apiKey = aApiKey;
}

+ (NSString *)getApiKey {
    return apiKey;
}

@end
