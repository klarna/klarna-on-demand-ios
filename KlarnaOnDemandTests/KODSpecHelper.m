#import "KODSpecHelper.h"
#import "BDError.h"
#import "BDRSACryptor.h"

@implementation KODSpecHelper

+ (void)resetKeychain {
  [self deleteAllKeysForSecClass:kSecClassGenericPassword];
  [self deleteAllKeysForSecClass:kSecClassInternetPassword];
  [self deleteAllKeysForSecClass:kSecClassCertificate];
  [self deleteAllKeysForSecClass:kSecClassKey];
  [self deleteAllKeysForSecClass:kSecClassIdentity];
}

+ (void)deleteAllKeysForSecClass:(CFTypeRef)secClass {
  NSMutableDictionary* dict = [NSMutableDictionary dictionary];
  [dict setObject:(__bridge id)secClass forKey:(__bridge id)kSecClass];
  OSStatus result = SecItemDelete((__bridge CFDictionaryRef) dict);
  NSAssert(result == noErr || result == errSecItemNotFound, @"Error deleting keychain data (%ld)", (long) result);
}

+ (BOOL)tagExistsInKeychain:(NSString *)tag {
  BDError *error = [[BDError alloc] init];
  BDRSACryptor *rsaCryptor = [[BDRSACryptor alloc] init];

  [rsaCryptor keyRefWithTag:tag error:error];
  return error.errors.count == 0;
}

+ (NSString *)privateKeyForTag:(NSString *)tag {
  BDRSACryptor *rsaCryptor = [[BDRSACryptor alloc] init];
  BDError *error = [[BDError alloc] init];
  
  NSString *privateKey = [rsaCryptor PEMFormattedPrivateKey:tag error:error];
  return error.errors.count == 0 ? privateKey : nil;
}

+ (NSString *)publicKeyForTag:(NSString *)tag {
  BDRSACryptor *rsaCryptor = [[BDRSACryptor alloc] init];
  BDError *error = [[BDError alloc] init];
  
  NSString *publicKey = [rsaCryptor X509FormattedPublicKey:@"bundle_identifier.publicKey.kia" error:error];
  return error.errors.count == 0 ? publicKey : nil;
}
@end
