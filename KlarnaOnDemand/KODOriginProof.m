#import "KODOriginProof.h"
#import "KODCrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "NSData+Base64.h"

@interface KODOriginProof ()

@property(nonatomic, assign) int amount;
@property(strong, nonatomic) NSString *currency;
@property(strong, nonatomic) NSString *userToken;
@property(strong, nonatomic) NSString *uuid;
@property(nonatomic, assign) SecKeyRef externalPrivateKey;
@property(strong, nonatomic) NSString *originProofBase64Str;

@end

@implementation KODOriginProof

- (id)initWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken {
    return [self initWithAmount:amount currency:currency userToken:userToken externalPrivateKey:NULL];
}

- (id)initWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken externalPrivateKey:(SecKeyRef)externalPrivateKey {
    self = [super init];
    if (self) {
        self.amount = amount;
        self.currency = currency;
        self.userToken = userToken;
        self.uuid = [[NSUUID UUID] UUIDString];
        self.externalPrivateKey = externalPrivateKey;
        self.originProofBase64Str = [self generateBase64Str];
    }
    return self;
}


- (id)init {
  NSAssert(NO, @"Initialize with -initWithAmount:currency:userToken");
  return nil;
}

- (NSString *)description {
  return self.originProofBase64Str;
}

- (NSString *)generateBase64Str {
  NSData *data = [self jsonDataWithDictionary:@{@"amount":[NSNumber numberWithInt: self.amount],
                                                @"currency":self.currency,
                                                @"user_token":self.userToken,
                                                @"id":self.uuid}];

  NSString *signature;
  if(self.externalPrivateKey != NULL) {
    signature = [KODCrypto signWithData:data andPrivateKey:self.externalPrivateKey];
  }
  else {
    signature = [[KODCrypto sharedKODCrypto] signWithData:data];
  }
  NSAssert(signature.length > 0, @"KOD signature creation failed.");

  NSDictionary *originProof = @{@"data": [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],
                                @"signature": signature};

  NSString *base64EncodedOriginProof = [[self jsonDataWithDictionary:originProof] base64EncodedString];

  return base64EncodedOriginProof;
}

- (NSData *)jsonDataWithDictionary:(NSDictionary *) dictionary {
  return [NSJSONSerialization dataWithJSONObject:dictionary
                                         options:0
                                           error:nil];
}

@end
