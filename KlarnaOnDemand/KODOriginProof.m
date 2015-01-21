#import "KODOriginProof.h"
#import "KODCrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "NSData+Base64.h"

@implementation KODOriginProof

+ (NSString *)generateWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken {
  NSData *data = [self jsonDataWithDictionary:@{@"amount": [NSNumber numberWithInt:amount],
                                                @"currency": currency,
                                                @"user_token": userToken,
                                                @"id": [[NSUUID UUID] UUIDString]}];
  
  NSString *signature = [[KODCrypto sharedKODCrypto] signWithData:data];
  NSAssert(signature.length > 0, @"KOD signature creation failed.");
  
  NSDictionary *originProof = @{@"data": [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],
                                @"signature": signature};
  
  NSString *base64EncodedOriginProof = [[self jsonDataWithDictionary:originProof] base64EncodedString];

  return base64EncodedOriginProof;
}

+ (NSData *)jsonDataWithDictionary:(NSDictionary *) dictionary {
  return [NSJSONSerialization dataWithJSONObject:dictionary
                                         options:0
                                           error:nil];
}

@end
