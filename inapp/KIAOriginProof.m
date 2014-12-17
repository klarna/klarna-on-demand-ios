#import "KIAOriginProof.h"
#import "KIACrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "NSData+Base64.h"

@implementation KIAOriginProof

+ (NSString *)generateWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken {
  NSDictionary *proofParams = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:amount] , @"amount",
                               currency, @"currency",
                               userToken, @"user_token",
                               [self timestamp], @"timestamp",
                               nil];
  
  NSData *data = [self jsonWithDictionary:proofParams];
  
  NSString *signature = [[KIACrypto sharedKIACrypto] getSignatureWithText:data];
  
  NSDictionary *originProof = [NSDictionary dictionaryWithObjectsAndKeys:
                               [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], @"data",
                               signature, @"signature",
                               nil];
  
  
  return [[self jsonWithDictionary:originProof] base64EncodedString];
}

+ (NSData *)jsonWithDictionary:(NSDictionary *) dictionary {
  NSError *error;
  return [NSJSONSerialization dataWithJSONObject:dictionary
                                         options:NSJSONWritingPrettyPrinted
                                           error:&error];
}

+ (NSString *)timestamp {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
  [dateFormatter setLocale:enUSPOSIXLocale];
  [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
  
  NSDate *now = [NSDate date];
  return [dateFormatter stringFromDate:now];
}

@end
