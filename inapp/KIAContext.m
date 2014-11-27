#import "KIAContext.h"

@interface KIAContext()

+ (NSString *)getApiKey;

@end

@implementation KIAContext

static NSString *apiKey;

+ (void)setApiKey:(NSString *)aApiKey {
    apiKey = aApiKey;
}

+ (NSString *)getApiKey {
    return apiKey;
}

@end
