#import "KIAOriginProof.h"
#import "KIACrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "BDRSACryptor.h"
#import "BDError.h"
#import "NSString+Base64.h"

@interface KIAOriginProof (Test)

+ (NSString *)timestamp;

@end

SPEC_BEGIN(KIAOriginProofSpec)

describe(@".generateWithAmount", ^{
  
  beforeEach(^{
    [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
    [KIAOriginProof stub:@selector(timestamp) andReturn:@"2014-12-15T18:44:06.037+02:00"];
    [[KIACrypto sharedKIACrypto] stub:@selector(getSignatureWithData:) andReturn:@"my_signature"];
  });
  
  it(@"should return a base64 encoded json in the correct format", ^{
    NSString *originProof = [KIAOriginProof generateWithAmount:3600 currency:@"SEK" userToken:@"my_token"];
    
    NSData *decodedriginProof = [[NSData alloc] initWithBase64EncodedString:originProof options:0];
    NSDictionary *originProofDic = [NSJSONSerialization JSONObjectWithData: decodedriginProof
                                                                   options: NSJSONReadingMutableContainers
                                                                     error: nil];
    
    NSData *data = [originProofDic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    [[dataDic[@"amount"] should] equal:[NSNumber numberWithInt:3600]];
    [[dataDic[@"currency"] should] equal:@"SEK"];
    [[dataDic[@"user_token"] should] equal:@"my_token"];
    [[dataDic[@"timestamp"] should] equal:[KIAOriginProof timestamp]];
    [[originProofDic[@"signature"] should] equal:@"my_signature"];
  });
  
});

describe(@".timestamp", ^{
  NSDate *now = [NSDate dateWithTimeIntervalSince1970:0];
  [NSDate stub:@selector(date) andReturn:now];

  [[[KIAOriginProof timestamp] should] equal:@"1970-01-01T02:00:00+02:00"];
});

SPEC_END