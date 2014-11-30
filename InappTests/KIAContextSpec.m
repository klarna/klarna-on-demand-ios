#import "KIAContext.h"

SPEC_BEGIN(KIAContextSpec)

describe(@".getApiKey", ^{
    
    it(@"should throw exception when API key is not set", ^{
      [[theBlock(^{[KIAContext getApiKey];}) should] raiseWithName:@"NSInternalInconsistencyException" reason:@"You must set the API key first!"];
    });
    
    it(@"should return the API key when API key is set", ^{
      [KIAContext setApiKey:@"my_key"];
        
      [[[KIAContext getApiKey] should] equal:@"my_key"];
    });
});

SPEC_END
