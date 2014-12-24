#import "KIAOriginProof.h"
#import "KIACrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "NSData+Base64.h"

@implementation KIAOriginProof

+ (NSString *)generateWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken {
  NSData *transactionData = [self jsonDataWithDictionary:@{@"amount": [NSNumber numberWithInt:amount],
                                                @"currency": currency,
                                                @"user_token": userToken,
                                                @"timestamp": [self timestamp]}];
  
  NSString *signature = [[KIACrypto sharedKIACrypto] getSignatureWithData:transactionData];
  NSAssert(signature.length > 0, @"KIA signature creation failed.");
  
  NSDictionary *originProof = @{@"data": [[NSString alloc] initWithData:transactionData encoding:NSUTF8StringEncoding],
                                @"signature": signature};
  
  NSString *originProofAsString = [[self jsonDataWithDictionary:originProof] base64EncodedString];

  return originProofAsString;
}

+ (NSData *)jsonDataWithDictionary:(NSDictionary *) dictionary {
  return [NSJSONSerialization dataWithJSONObject:dictionary
                                         options:0
                                           error:nil];
}

+ (NSString *)timestamp {
  NSDate *now = [NSDate date];
  return [[self iso8601DateFormatter] stringFromDate:now];
}

+ (NSDateFormatter *)iso8601DateFormatter {
  static NSDateFormatter *iso8601DateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    iso8601DateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [iso8601DateFormatter setLocale:enUSPOSIXLocale];
    [iso8601DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
  });
  
  return iso8601DateFormatter;
}

@end
