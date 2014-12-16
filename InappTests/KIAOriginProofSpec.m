#import "KIAOriginProof.h"
#import <Foundation/NSJSONSerialization.h>

SPEC_BEGIN(KIAOriginProofSpec)

describe(@".generateWithAmount", ^{
  
  it(@"should return base 64 json with the rigth format", ^{
    NSString *originProof = [KIAOriginProof generateWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
    
    NSData *decodedriginProof = [[NSData alloc] initWithBase64EncodedString:originProof options:0];
    NSDictionary *originProofDic = [NSJSONSerialization JSONObjectWithData: decodedriginProof
                                                         options: NSJSONReadingMutableContainers
                                                           error: nil];

    [[originProofDic[@"data"] should] equal:@"{\"amount\":3600,\"currency\"SEK\",\"timestamp\"2014-12-15T18:44:06.037+02:00\",\"user_token\"my_token\"}"];
    [[originProofDic[@"signature"] should] equal:@"ddd"];
  });
});

SPEC_END