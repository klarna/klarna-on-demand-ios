#import "KIACrypto.h"
#import "BDRSACryptor.h"
#import "BDRSACryptorKeyPair.h"
#import "BDError.h"
#import "BDLog.h"
#import <Security/SecBase.h>
#include <CommonCrypto/CommonDigest.h>
#import "NSData+Base64.h"
#import "NSString+Base64.h"

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
    
    NSString *publicKeyTag = [RSACryptor publicKeyIdentifierWithTag:KIA_TAG];
    NSString *privateKeyTag = [RSACryptor privateKeyIdentifierWithTag:KIA_TAG];
    
    SecKeyRef publicKeyRef = [RSACryptor keyRefWithTag:publicKeyTag error:error];
    SecKeyRef privateKeyRef = [RSACryptor keyRefWithTag:privateKeyTag error:error];
    if (publicKeyRef && privateKeyRef)
    {
      NSString *publicKeyStr = [RSACryptor X509FormattedPublicKey:publicKeyTag error:error];
      _publicKeyBase64Str = [publicKeyStr base64EncodedString];
    }
    else
    {
      BDRSACryptorKeyPair *RSAKeyPair = [RSACryptor generateKeyPairWithKeyIdentifier:KIA_TAG error:error];
      if(RSAKeyPair == nil)
        return nil;
      _publicKeyBase64Str = [RSAKeyPair.publicKey base64EncodedString];
    }
  }
  return self;
}


- (NSString *)getSignatureWithData:(NSData *)plainData {
  
  BDRSACryptor *RSACryptor = [[BDRSACryptor alloc] init];
  BDError *error = [[BDError alloc] init];
  
  NSString *privateKeyTag = [RSACryptor privateKeyIdentifierWithTag:KIA_TAG];
  SecKeyRef privateKey = [RSACryptor keyRefWithTag:privateKeyTag error:error];
  
  size_t signedHashBytesSize = SecKeyGetBlockSize(privateKey);
  uint8_t* signedHashBytes = malloc(signedHashBytesSize);
  memset(signedHashBytes, 0x0, signedHashBytesSize);
  
  size_t hashBytesSize = CC_SHA256_DIGEST_LENGTH;
  uint8_t* hashBytes = malloc(hashBytesSize);
  if (!CC_SHA256([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
    return nil;
  }
  
  SecKeyRawSign(privateKey,
                kSecPaddingPKCS1SHA256,
                hashBytes,
                hashBytesSize,
                signedHashBytes,
                &signedHashBytesSize);
  
  NSData* signedHash = [NSData dataWithBytes:signedHashBytes
                                      length:(NSUInteger)signedHashBytesSize];
  
  if (hashBytes)
    free(hashBytes);
  if (signedHashBytes)
    free(signedHashBytes);
  
  return [signedHash base64EncodedString];
}

@end
