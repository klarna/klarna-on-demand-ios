#import "KODContext.h"

SPEC_BEGIN(KODContextSpec)

describe(@".getApiKey", ^{
  
  it(@"should throw an exception when the API key is not set", ^{
    [[theBlock(^{[KODContext getApiKey];}) should] raiseWithName:@"NSInternalInconsistencyException" reason:@"You must set the API key first."];
  });
  
  it(@"should return the API key previously set", ^{
    [KODContext setApiKey:@"my_key"];

    [[[KODContext getApiKey] should] equal:@"my_key"];

    [KODContext setApiKey:nil];
  });
});

describe(@".getPreferredLocale", ^{
  
  it(@"should return the default locale if preferred locale was not set", ^{
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"en"]];
    
    [[[KODContext getPreferredLocale] should] equal:@"en"];
  });
  
  it(@"should return the preferred locale previously set", ^{
    [KODContext setPreferredLocale:@"sv"];
    
    [[[KODContext getPreferredLocale] should] equal:@"sv"];
    
    [KODContext setPreferredLocale:nil];
  });
});

SPEC_END
