#import "KIAUrl.h"
#import "KIAContext.h"
#import "KIACrypto.h"

#define KLARNA_PLAYGROUND_URL @"https://inapp.playground.klarna.com"
#define KLARNA_PRODUCTION_URL @"https://inapp.klarna.com"

@implementation KIAUrl

+ (NSURL *)registrationUrl {
  NSString *publicKeyBase64Str = [[KIACrypto sharedKIACrypto] publicKeyBase64Str];
  NSString *url = [NSString stringWithFormat:@"%@/registration/new?api_key=%@&locale=%@&public_key=%@", [self baseUrl], [KIAContext getApiKey], [self locale], publicKeyBase64Str];
  return [NSURL URLWithString:url];
}

+ (NSURL *)preferencesUrlWithToken:(NSString *)token {
  NSString *url = [NSString stringWithFormat:@"%@/users/%@/preferences?api_key=%@&locale=%@", [self baseUrl], token, [KIAContext getApiKey], [self locale]];
  return [NSURL URLWithString:url];
}

+ (NSString *)baseUrl {
  if ([[KIAContext getApiKey] hasPrefix:@"test_"]) {
    return KLARNA_PLAYGROUND_URL;
  }
  return KLARNA_PRODUCTION_URL;
}

+ (NSString *)locale {
  return [[NSBundle mainBundle] preferredLocalizations].firstObject;
}

@end
