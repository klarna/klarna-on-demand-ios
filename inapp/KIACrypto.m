#import "KIACrypto.h"
#import "BDRSACryptor.h"
#import "BDRSACryptorKeyPair.h"
#import "BDError.h"
#import "BDLog.h"

@implementation KIACrypto

#define KIA_TAG @"kia"


+ (id)sharedKIACrypto {
  static KIACrypto *sharedKIACrypto = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedKIACrypto = [[self alloc] init];
  });
  return sharedKIACrypto;
}

- (id)init {
  if (self = [super init]) {
    BDError *error = [[BDError alloc] init];
    BDRSACryptor *RSACryptor = [[BDRSACryptor alloc] init];
    
    BDRSACryptorKeyPair *RSAKeyPair = [RSACryptor generateKeyPairWithKeyIdentifier:KIA_TAG error:error];
    
    _publicKeyBase64Str = [[RSAKeyPair.publicKey dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
  }
  return self;
}


- (NSString *)getSignatureWithText:(NSString *)plainText {
  return @"dd";
}

@end
