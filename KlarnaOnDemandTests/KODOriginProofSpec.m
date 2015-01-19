#import "KODOriginProof.h"
#import "KODCrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "BDRSACryptor.h"
#import "BDError.h"
#import "NSString+Base64.h"

SPEC_BEGIN(KODOriginProofSpec)

describe(@".generateWithAmount", ^{
  
  beforeEach(^{
    [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
    [[KODCrypto sharedKODCrypto] stub:@selector(getSignatureWithData:) andReturn:@"my_signature"];
  });
  
  it(@"should return a base64 encoded json in the correct format", ^{
    NSString *originProof = [KODOriginProof generateWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
    
    NSData *decodedriginProof = [[NSData alloc] initWithBase64EncodedString:originProof options:0];
    NSDictionary *originProofDic = [NSJSONSerialization JSONObjectWithData: decodedriginProof
                                                                   options: NSJSONReadingMutableContainers
                                                                     error: nil];
    
    NSData *data = [originProofDic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    [[dataDic[@"amount"] should] equal:[NSNumber numberWithInt:3600]];
    [[dataDic[@"currency"] should] equal:@"SEK"];
    [[dataDic[@"user_token"] should] equal:@"my_token"];
    [[dataDic[@"id"] should] matchPattern:@"[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}"];
    [[originProofDic[@"signature"] should] equal:@"my_signature"];
  });
  
  it(@"should generate different id for each order", ^{
    NSString *originProofA = [KODOriginProof generateWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
    NSData *decodedriginProofA = [[NSData alloc] initWithBase64EncodedString:originProofA options:0];
    NSDictionary *originProofDicA = [NSJSONSerialization JSONObjectWithData: decodedriginProofA
                                                                   options: NSJSONReadingMutableContainers
                                                                      error: nil];
    NSData *dataA = [originProofDicA[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDicA = [NSJSONSerialization JSONObjectWithData:dataA options:0 error:nil];
    
    NSString *originProofB = [KODOriginProof generateWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
    NSData *decodedriginProofB = [[NSData alloc] initWithBase64EncodedString:originProofB options:0];
    NSDictionary *originProofDicB = [NSJSONSerialization JSONObjectWithData: decodedriginProofB
                                                                    options: NSJSONReadingMutableContainers
                                                                      error: nil];
    NSData *dataB = [originProofDicB[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDicB = [NSJSONSerialization JSONObjectWithData:dataB options:0 error:nil];
    
    [[dataDicA[@"id"] shouldNot] equal:dataDicB[@"id"]];
  });
});

SPEC_END