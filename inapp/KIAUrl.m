#import "KIAUrl.h"
#import "KIAContext.h"

@interface KIAUrl()
+ (NSString *)baseUrl;
+ (NSString *)locale;

@end

@implementation KIAUrl

+ (NSURL *)registrationUrl {
  NSString *url = [NSString stringWithFormat:@"%@/registration/new?api_key=%@&locale=%@", [self baseUrl], [KIAContext getApiKey], [self locale]];
  return [NSURL URLWithString:url];
}

+ (NSString *)baseUrl {
  if ([[KIAContext getApiKey] hasPrefix:@"test_"]) {
    return @"https://inapp.playground.klarna.com";
  }
  return @"https://inapp.klarna.com";
}

+ (NSString *)locale {
  return [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
}

@end
