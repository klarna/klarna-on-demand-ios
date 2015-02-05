#import "KODUrl.h"
#import "KODContext.h"
#import "KODCrypto.h"

@implementation KODUrl

NSString *const KlarnaPlaygroundUrl = @"https://inapp.playground.klarna.com";
NSString *const KlarnaProductionUrl = @"https://inapp.klarna.com";

+ (NSURL *)registrationUrl {
  NSString *publicKeyBase64Str = [[KODCrypto sharedKODCrypto] publicKeyBase64Str];

  NSString *url = [NSString stringWithFormat:@"%@/registration/new?api_key=%@&locale=%@&public_key=%@",
                   [self baseUrl],
                   [KODContext getApiKey],
                   [self locale],
                   [self urlEncodeWithParam:publicKeyBase64Str]];
  return [NSURL URLWithString:url];
}

+ (NSURL *)preferencesUrlWithToken:(NSString *)token {
  NSString *url = [NSString stringWithFormat:@"%@/users/%@/preferences?api_key=%@&locale=%@", [self baseUrl], token, [KODContext getApiKey], [self locale]];
  return [NSURL URLWithString:url];
}

+ (NSString *)baseUrl {
  if ([[KODContext getApiKey] hasPrefix:@"test_"]) {
    return KlarnaPlaygroundUrl;
  }
  return KlarnaProductionUrl;
}

+ (NSString *)locale {
  return [[NSBundle mainBundle] preferredLocalizations].firstObject;
}

+ (NSString *) urlEncodeWithParam:(NSString *)param {
  return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                               NULL,
                                                                               (CFStringRef)param,
                                                                               NULL,
                                                                               (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                               kCFStringEncodingUTF8 ));
}

@end
