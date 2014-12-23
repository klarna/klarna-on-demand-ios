#import "KIAContext.h"
#import "KIAUrl.h"
#import "KIACrypto.h"

SPEC_BEGIN(KIAUrlSpec)

describe(@".registrationUrl", ^{
  
  beforeEach(^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });
  
  it(@"should return a playground registration url when token is for playground", ^{
    
    NSString *registrationUrl = [KIAUrl registrationUrl].absoluteString;
    [[theValue([registrationUrl hasPrefix:@"https://inapp.playground.klarna.com/registration/new"]) should] equal:theValue(YES)];
  });
  
  it(@"should return a production registration url when token is for production", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    
    NSString *registrationUrl = [KIAUrl registrationUrl].absoluteString;
    [[theValue([registrationUrl hasPrefix:@"https://inapp.klarna.com/registration/new"]) should] equal: theValue(YES)];
  });
  
  it(@"should return a url with Swedish locale when locale is Swedish", ^{
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"sv"]];
    
    NSString *registrationUrl = [KIAUrl registrationUrl].absoluteString;
    [[registrationUrl should] containString:@"locale=sv"];
  });
  
  it(@"should include the public key in reigstration url", ^{
    [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
    [[KIACrypto sharedKIACrypto] stub:@selector(publicKeyBase64Str) andReturn:@"skadoo_public_key"];
    
    NSString *registrationUrl = [KIAUrl registrationUrl].absoluteString;
    [[registrationUrl should] containString:@"public_key=skadoo_public_key"];
  });
});

describe(@".preferencesUrlWithToken:", ^{
  
  let(token, ^id{
    return @"my_token";
  });
  
  it(@"should return a playground preferences url when token is for playground", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"test_skadoo"];
    
    NSString *preferencesUrl = [KIAUrl preferencesUrlWithToken:token].absoluteString;
    NSString *expectedPrefix = [NSString stringWithFormat:@"%@%@%@",@"https://inapp.playground.klarna.com/users/", token, @"/preferences"];
    [[theValue([preferencesUrl hasPrefix:expectedPrefix]) should] equal:theValue(YES)];
  });
  
  it(@"should return a production preferences url when token is for production", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    
    NSString *preferencesUrl = [KIAUrl preferencesUrlWithToken:token].absoluteString;
    NSString *expectedPrefix = [NSString stringWithFormat:@"%@%@%@",@"https://inapp.klarna.com/users/", token, @"/preferences"];
    [[theValue([preferencesUrl hasPrefix:expectedPrefix]) should] equal:theValue(YES)];
  });
  
  it(@"should return a url with Swedish locale when locale is Swedish", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"sv"]];
    
    NSString *preferencesUrl = [KIAUrl preferencesUrlWithToken:token].absoluteString;
    [[preferencesUrl should] containString:@"locale=sv"];
  });
  
});

SPEC_END