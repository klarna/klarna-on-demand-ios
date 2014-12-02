#import "KIAContext.h"
#import "KIAUtils.h"

@implementation KIAContext

static NSString *apiKey;

+ (void)setApiKey:(NSString *)aApiKey {
    apiKey = aApiKey;
}

+ (bool)userFinishedRegistration {
  return [KIAUtils getUserToken] != nil;
}

+ (NSString *)getApiKey {
    [self validateApiKey];
    return apiKey;
}

+ (void)validateApiKey {
    NSCAssert(apiKey != nil && ![apiKey isEqualToString:@""], @"You must set the API key first.");
}

@end
