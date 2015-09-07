#import "KODContext.h"

@implementation KODContext

static NSString *apiKey;
static UIColor *buttonColor;
static UIColor *linkColor;

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

+ (UIColor *)getButtonColor {
    return buttonColor;
}

+ (void)setButtonColor:(UIColor *)aButtonColor {
    buttonColor = aButtonColor;
}

+ (UIColor *)getLinkColor {
    return linkColor;
}

+ (void)setLinkColor:(UIColor *)aLinkColor {
    linkColor = aLinkColor;
}

@end
