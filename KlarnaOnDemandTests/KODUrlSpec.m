#import "KODContext.h"
#import "KODUrl.h"
#import "KODCrypto.h"

SPEC_BEGIN(KODUrlSpec)

describe(@".registrationUrlWithSettings:", ^{

  beforeEach(^{
    [[KODContext class] stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });

  it(@"should return a playground registration url when token is for playground", ^{
    
    NSString *registrationUrl = [KODUrl registrationUrlWithSettings:nil].absoluteString;
    [[theValue([registrationUrl hasPrefix:@"https://inapp.playground.klarna.com/registration/new"]) should] equal:theValue(YES)];
  });

  it(@"should return a production registration url when token is for production", ^{
    [[KODContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    
    NSString *registrationUrl = [KODUrl registrationUrlWithSettings:nil].absoluteString;
    [[theValue([registrationUrl hasPrefix:@"https://inapp.klarna.com/registration/new"]) should] equal: theValue(YES)];
  });

  it(@"should return a url with Swedish locale when locale is Swedish", ^{
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"sv"]];
    
    NSString *registrationUrl = [KODUrl registrationUrlWithSettings:nil].absoluteString;
    [[registrationUrl should] containString:@"locale=sv"];
  });

  it(@"should include the public key in the registration url", ^{
    [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
    [[KODCrypto sharedKODCrypto] stub:@selector(publicKeyBase64Str) andReturn:@"skadoo_public_key"];
    
    NSString *registrationUrl = [KODUrl registrationUrlWithSettings:nil].absoluteString;
    [[registrationUrl should] containString:@"public_key=skadoo_public_key"];
  });

  it(@"should url encode public key", ^{
    [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
    [[KODCrypto sharedKODCrypto] stub:@selector(publicKeyBase64Str) andReturn:@"skadoo+public+key"];
    
    NSString *registrationUrl = [KODUrl registrationUrlWithSettings:nil].absoluteString;
    [[registrationUrl should] containString:@"public_key=skadoo%2Bpublic%2Bkey"];
  });

  it(@"should include the api key in the registration url", ^{
    NSString *registrationUrl = [KODUrl registrationUrlWithSettings:nil].absoluteString;
    [[registrationUrl should] containString: [NSString stringWithFormat:@"api_key=%@",[KODContext getApiKey]]];
  });

  it(@"should include confirmed user data id in the registration url when supplied", ^{
    KODRegistrationSettings *registrationSettings = [[KODRegistrationSettings alloc] initWithPrefillPhoneNumber:nil andConfirmedUserDataId:@"abcd"];
    NSString *registrationUrl = [KODUrl registrationUrlWithSettings:registrationSettings].absoluteString;
    [[registrationUrl should] containString: [NSString stringWithFormat:@"confirmed_user_data_id=abcd"]];
  });

  it(@"should include phone number in the registration url when supplied", ^{
      KODRegistrationSettings *registrationSettings = [[KODRegistrationSettings alloc] initWithPrefillPhoneNumber:@"12345678" andConfirmedUserDataId:nil];

    NSString *registrationUrl = [KODUrl registrationUrlWithSettings:registrationSettings].absoluteString;
    [[registrationUrl should] containString: [NSString stringWithFormat:@"prefill_phone_number=12345678"]];
  });
});

describe(@".preferencesUrlWithToken:", ^{

  beforeEach(^{
    [[KODContext class] stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });

  let(token, ^id{
    return @"my_token";
  });

  it(@"should return a playground preferences url when token is for playground", ^{
    NSString *preferencesUrl = [KODUrl preferencesUrlWithToken:token].absoluteString;
    NSString *expectedPrefix = [NSString stringWithFormat:@"%@%@%@",@"https://inapp.playground.klarna.com/users/", token, @"/preferences"];
    [[theValue([preferencesUrl hasPrefix:expectedPrefix]) should] equal:theValue(YES)];
  });

  it(@"should return a production preferences url when token is for production", ^{
    [[KODContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    
    NSString *preferencesUrl = [KODUrl preferencesUrlWithToken:token].absoluteString;
    NSString *expectedPrefix = [NSString stringWithFormat:@"%@%@%@",@"https://inapp.klarna.com/users/", token, @"/preferences"];
    [[theValue([preferencesUrl hasPrefix:expectedPrefix]) should] equal:theValue(YES)];
  });

  it(@"should return a url with Swedish locale when locale is Swedish", ^{
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"sv"]];
    
    NSString *preferencesUrl = [KODUrl preferencesUrlWithToken:token].absoluteString;
    [[preferencesUrl should] containString:@"locale=sv"];
  });

  it(@"should include the api key in the the preferences url", ^{
    NSString *preferencesUrl = [KODUrl preferencesUrlWithToken:token].absoluteString;
    [[preferencesUrl should] containString: [NSString stringWithFormat:@"api_key=%@",[KODContext getApiKey]]];
  });
});

SPEC_END