#import "KIAContext.h"
#import "KIAUrl.h"

SPEC_BEGIN(KIAUrlSpec)

describe(@".registrationUrl", ^{
  
  it(@"should return a playground registration url when token is for playground", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"test_skadoo"];
    
    [[[KIAUrl registrationUrl].absoluteString should] equal:@"https://inapp.playground.klarna.com/registration/new?api_key=test_skadoo&locale=en"];
  });
  
  it(@"should return a production registration url when token is for production", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    
    [[[KIAUrl registrationUrl].absoluteString should] equal:@"https://inapp.klarna.com/registration/new?api_key=skadoo&locale=en"];
  });
  
  it(@"should return a url with Swedish locale when locale is Swedish", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"sv"]];
    
    [[[KIAUrl registrationUrl].absoluteString should] containString:@"locale=sv"];
  });
  
});

describe(@".preferencesUrlWithToken:", ^{
  
  let(token, ^id{
    return @"my_token";
  });
  
  it(@"should return a playground preferences url when token is for playground", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"test_skadoo"];
    
    [[[KIAUrl preferencesUrlWithToken:token].absoluteString should] equal:[NSString stringWithFormat:@"%@%@%@",@"https://inapp.playground.klarna.com/users/",token,@"/preferences?api_key=test_skadoo&locale=en"]];
  });
  
  it(@"should return a production preferences url when token is for production", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    
    [[[KIAUrl preferencesUrlWithToken:token].absoluteString should] equal:[NSString stringWithFormat:@"%@%@%@",@"https://inapp.klarna.com/users/",token,@"/preferences?api_key=skadoo&locale=en"]];
  });
  
  it(@"should return a url with Swedish locale when locale is Swedish", ^{
    [[KIAContext class] stub:@selector(getApiKey) andReturn:@"skadoo"];
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"sv"]];
    
    [[[KIAUrl preferencesUrlWithToken:token].absoluteString should] containString:@"locale=sv"];
  });
});

SPEC_END