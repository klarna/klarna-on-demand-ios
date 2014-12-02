#import "KIAContext.h"
#import "KIAUtils.h"
SPEC_BEGIN(KIAContextSpec)

describe(@".getApiKey", ^{
  
  it(@"should throw an exception when the API key is not set", ^{
    [[theBlock(^{[KIAContext getApiKey];}) should] raiseWithName:@"NSInternalInconsistencyException" reason:@"You must set the API key first."];
  });
  
  it(@"should return the API key previously set", ^{
    [KIAContext setApiKey:@"my_key"];
    
    [[[KIAContext getApiKey] should] equal:@"my_key"];
  });
});

describe(@".userFinishedRegistration", ^{
  
  it(@"should return false when token is not set", ^{
    [[theValue([KIAContext userFinishedRegistration]) should] equal:theValue(NO)];
  });
  
  it(@"should return true when token exists", ^{
    [KIAUtils stub:@selector(getUserToken) andReturn:@"my_token"];
    
    [[theValue([KIAContext userFinishedRegistration]) should] equal:theValue(YES)];
  });
});

SPEC_END
