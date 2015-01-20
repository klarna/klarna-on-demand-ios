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

SPEC_END
