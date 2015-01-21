#import "KODOriginProof.h"
#import "KODCrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "BDRSACryptor.h"
#import "BDError.h"
#import "NSString+Base64.h"
#import "KODSpecHelper.h"

SPEC_BEGIN(KODOriginProofSpec)

describe(@".generateWithAmount", ^{
  NSString *const UUID_PATTERN = @"[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}";
  
  beforeEach(^{
    [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
    [[KODCrypto sharedKODCrypto] stub:@selector(signWithData:) andReturn:@"my_signature"];
  });
  
  it(@"should return a base64 encoded json in the correct format", ^{
    NSString *originProof = [KODOriginProof generateWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
    NSDictionary *dataDic  = [KODSpecHelper dataDictionaryFromOriginProof:originProof];
    
    [[dataDic[@"amount"] should] equal:[NSNumber numberWithInt:3600]];
    [[dataDic[@"currency"] should] equal:@"SEK"];
    [[dataDic[@"user_token"] should] equal:@"my_token"];
    [[dataDic[@"id"] should] matchPattern:UUID_PATTERN];
    
    NSDictionary *originProofDic  = [KODSpecHelper originProofDictionaryFromOriginProof:originProof];
    [[originProofDic[@"signature"] should] equal:@"my_signature"];
  });
  
  it(@"should generate a different id for each order", ^{
    NSString *originProofA = [KODOriginProof generateWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
    NSDictionary *dataDicA  = [KODSpecHelper dataDictionaryFromOriginProof:originProofA];
    
    NSString *originProofB = [KODOriginProof generateWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
    NSDictionary *dataDicB  = [KODSpecHelper dataDictionaryFromOriginProof:originProofB];
    
    [[dataDicA[@"id"] shouldNot] equal:dataDicB[@"id"]];
  });
});

SPEC_END