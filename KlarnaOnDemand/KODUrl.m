#import "KODUrl.h"
#import "KODContext.h"
#import "KODCrypto.h"
#import "KODHelpers.h"

@implementation KODUrl

NSString *const KlarnaPlaygroundUrl = @"https://ondemand-dg.playground.klarna.com";
NSString *const KlarnaProductionUrl = @"https://ondemand.klarna.com";

+ (NSURL *)registrationUrl {
  NSString *publicKeyBase64Str = [[KODCrypto sharedKODCrypto] publicKeyBase64Str];

  NSString *url = [NSString stringWithFormat:@"%@/web/registration?in_app=true&flow=registration&api_key=%@&locale=%@&public_key=%@%@",
                   [self baseUrl],
                   [KODContext getApiKey],
                   [self locale],
                   [self urlEncodeWithParam:publicKeyBase64Str],
                   [self colorParams]];
  return [NSURL URLWithString:url];
}

+ (NSURL *)preferencesUrlWithToken:(NSString *)token {
  NSString *url = [NSString stringWithFormat:@"%@/web/preferences?in_app=true&flow=preferences&api_key=%@&user_token=%@&locale=%@%@", [self baseUrl], [KODContext getApiKey], token, [self locale], [self colorParams]];
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

+ (NSString *)colorParams {
  NSMutableString *params = [@"" mutableCopy];
  if ([KODContext getButtonColor]) {
    [params appendFormat:@"&color_button=%@", [self urlEncodeWithParam:[KODHelpers hexStringFromColor:[KODContext getButtonColor]]]];
  }
  if ([KODContext getLinkColor]) {
    [params appendFormat:@"&color_link=%@", [self urlEncodeWithParam:[KODHelpers hexStringFromColor:[KODContext getLinkColor]]]];
  }
  return params;
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
