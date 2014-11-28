#import "KIAContext.h"


SpecBegin(KIAContext_Test)

describe(@".getApiKey", ^{
    
    it(@"should throws exception when API key is not set", ^{
        [KIAContext setApiKey:nil];
        
        expect(^{[KIAContext getApiKey];}).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should return the setted API key", ^{
        [KIAContext setApiKey:@"my_key"];
        
        expect([KIAContext getApiKey]).to.equal(@"my_key");
    });
});

SpecEnd
