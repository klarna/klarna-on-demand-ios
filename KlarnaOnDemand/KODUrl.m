#import "KODUrl.h"
#import "KODContext.h"
#import "KODCrypto.h"
#import "KODRegistrationSettings.h"

@implementation KODUrl

NSString *const KlarnaPlaygroundUrl = @"https://inapp.playground.klarna.com";
NSString *const KlarnaProductionUrl = @"https://inapp.klarna.com";

+ (NSURL *)registrationUrlWithSettings: (KODRegistrationSettings *) registrationSettings {
  NSString *publicKeyBase64Str = [[KODCrypto sharedKODCrypto] publicKeyBase64Str];

  NSMutableString *url = [NSMutableString stringWithFormat:@"%@/registration/new?api_key=%@&locale=%@&public_key=%@",
                   [self baseUrl],
                   [KODContext getApiKey],
                   [self locale],
                   [self urlEncodeWithParam:publicKeyBase64Str]];

  if(registrationSettings != nil) {
    if(registrationSettings.confirmedUserDataId != nil) {
      [url appendString:[NSString stringWithFormat:@"&confirmed_user_data_id=%@", registrationSettings.confirmedUserDataId]];
    }
    if(registrationSettings.prefillPhoneNumber != nil) {
      [url appendString:[NSString stringWithFormat:@"&prefill_phone_number=%@", registrationSettings.prefillPhoneNumber]];
    }
  }

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
