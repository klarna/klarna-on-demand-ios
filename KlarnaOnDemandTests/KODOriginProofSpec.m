#import "KODOriginProof.h"
#import "KODCrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "BDRSACryptor.h"
#import "BDError.h"
#import "NSString+Base64.h"
#import "KODSpecHelper.h"

SPEC_BEGIN(KODOriginProofSpec)

NSString *const UUID_PATTERN = @"[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}";

void (^assertOriginProofData) (KODOriginProof *, int, NSString *, NSString *, NSString *) = ^void (KODOriginProof *originProof, int amount, NSString *currency, NSString *token, NSString *signature) {
  NSString *originProofStr = [originProof description];
  NSDictionary *originProofDictionary = [KODSpecHelper originProofDictionaryFromOriginProof:originProofStr];
  [[originProofDictionary[@"signature"] should] equal:signature];

  NSDictionary *originProofDataDictionary = [KODSpecHelper dataDictionaryFromOriginProof:originProofStr];
  [[originProofDataDictionary[@"amount"] should] equal:[NSNumber numberWithInt:amount]];
  [[originProofDataDictionary[@"currency"] should] equal:currency];
  [[originProofDataDictionary[@"user_token"] should] equal:token];
  [[originProofDataDictionary[@"id"] should] matchPattern:UUID_PATTERN];
};

describe(@"#description", ^{
  
  beforeEach(^{
    [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
  });
  
  describe(@"without external private key", ^{
    beforeEach(^{
      [[KODCrypto sharedKODCrypto] stub:@selector(signWithData:) andReturn:@"my_signature"];
    });
    
    it(@"should return a base64 encoded json in the correct format", ^{
      KODOriginProof *originProof = [[KODOriginProof alloc] initWithAmount:3600 currency:@"SEK" userToken:@"my_token"];

      assertOriginProofData(originProof, 3600, @"SEK", @"my_token", @"my_signature");
    });
    
    it(@"should generate a different id for each order", ^{
      KODOriginProof *originProofA = [[KODOriginProof alloc] initWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
      NSDictionary *originProofDictionaryA = [KODSpecHelper dataDictionaryFromOriginProof:[originProofA description]];

      KODOriginProof *originProofB = [[KODOriginProof alloc] initWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
      NSDictionary *originProofDictionaryB = [KODSpecHelper dataDictionaryFromOriginProof:[originProofB description]];

      [[originProofDictionaryA[@"id"] shouldNot] equal:originProofDictionaryB[@"id"]];
    });
  });
  
  describe(@"without external private key", ^{
    beforeEach(^{
      [KODCrypto stub:@selector(signWithData:andPrivateKey:) andReturn:@"my_signature"];
    });
    
    it(@"should return a base64 encoded json in the correct format", ^{
      SecKeyRef privateKey = [KODSpecHelper generatePrivateKey];
      
      KODOriginProof *originProof = [[KODOriginProof alloc] initWithAmount:3600 currency:@"SEK" userToken:@"my_token" externalPrivateKey:privateKey];
      
      assertOriginProofData(originProof, 3600, @"SEK", @"my_token", @"my_signature");
    });
      
    it(@"should generate a different id for each order", ^{
      SecKeyRef privateKey = [KODSpecHelper generatePrivateKey];
      KODOriginProof *originProofA = [[KODOriginProof alloc] initWithAmount:3600 currency:@"SEK" userToken:@"my_token" externalPrivateKey:privateKey];
      NSDictionary *originProofDictionaryA = [KODSpecHelper dataDictionaryFromOriginProof:[originProofA description]];
      
      KODOriginProof *originProofB = [[KODOriginProof alloc] initWithAmount:3600 currency:@"SEK" userToken:@"my_token" externalPrivateKey:privateKey];
      NSDictionary *originProofDictionaryB = [KODSpecHelper dataDictionaryFromOriginProof:[originProofB description]];
      
      [[originProofDictionaryA[@"id"] shouldNot] equal:originProofDictionaryB[@"id"]];
    });
  });
});

SPEC_END