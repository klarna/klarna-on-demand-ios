#import <Foundation/Foundation.h>

#import "KIAOriginProof.h"
#import "KIACrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "BDRSACryptor.h"
#import "BDError.h"
#import "NSString+Base64.h"

@interface KIACrypto (Test)

+(void)resetKeychain;

@end

@implementation KIACrypto (Test)

+(void)resetKeychain {
  [self deleteAllKeysForSecClass:kSecClassGenericPassword];
  [self deleteAllKeysForSecClass:kSecClassInternetPassword];
  [self deleteAllKeysForSecClass:kSecClassCertificate];
  [self deleteAllKeysForSecClass:kSecClassKey];
  [self deleteAllKeysForSecClass:kSecClassIdentity];
}

+(void)deleteAllKeysForSecClass:(CFTypeRef)secClass {
  NSMutableDictionary* dict = [NSMutableDictionary dictionary];
  [dict setObject:(__bridge id)secClass forKey:(__bridge id)kSecClass];
  OSStatus result = SecItemDelete((__bridge CFDictionaryRef) dict);
  NSAssert(result == noErr || result == errSecItemNotFound, @"Error deleting keychain data (%ld)", (long) result);
}

@end

SPEC_BEGIN(KIACryptoSpec)

beforeEach(^{
  [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
});

describe(@".getSignatureWithText", ^{
  
  it(@"should calculate a valid signature", ^{
    BDRSACryptor *rsaCryptor = [[BDRSACryptor alloc] init];
    BDError *error = [[BDError alloc] init];
    [rsaCryptor setPrivateKey:@"-----BEGIN RSA PRIVATE KEY-----\nMIIBOgIBAAJBAK3h0RtywI11idN0CfZlyo1LhA/7ssmGN5Wl+qNdk+/d0xVpb50U\nWr1gdmaBkbYEsDj1EbaVtChA9tKtFMNw9PkCAwEAAQJANSQHYSkf2durJJmZFdmk\nHqyOjsfwqxA+2phgUh8eQDb8z5Bv5DYmgpDMI7wBzfYtJtS2j40/2Ium8VQgJp7P\nAQIhAN6X1HQCJhfVh5lAEjcsIlOiu+UrAB6P2zYouk24iUghAiEAx/p6ssSi12rK\nERMOcAzbLVIjYGi4CcGCU2HvyxW0sdkCICVuqPadSeSmLvhxkt6eWGNyMWDXe1yo\nWnfgH3xkdQmhAiEAlMRf1vG1eq+01vLoQK8vtg1ux9/fWVKdk04+R0REgjECIACX\njuUhQyJKyGGEF+2NOnEix/6Eo+gM6rkyaIfDC3Nb\n-----END RSA PRIVATE KEY-----\n" tag:[rsaCryptor privateKeyIdentifierWithTag:@"kia"] error:error];
    
    NSString *signature = [[KIACrypto sharedKIACrypto] getSignatureWithData:[@"my_data" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[signature should] equal:@"Qx4Lcud2ECP+cJhg9zYAUFuc9WNoB141W3Chxok5cI7xG44xkxmWn27heccUBvS8G/rP2P1U1YE8DMEf/PhQKw=="];
  });
});

describe(@".init", ^{
  
  it(@"should create a private key in keychain with the correct tag", ^{
    [KIACrypto resetKeychain];
    [[KIACrypto alloc] init];
    
    BDRSACryptor *rsaCryptor = [[BDRSACryptor alloc] init];
    BDError *error = [[BDError alloc] init];

    [rsaCryptor keyRefWithTag:@"bundle_identifier.privateKey.kia" error:error];
    [[theValue(error.errors.count) should] equal:theValue(0)];
    
    [rsaCryptor keyRefWithTag:@"bundle_identifier.publicKey.kia" error:error];
    [[theValue(error.errors.count) should] equal:theValue(0)];
  });
  
  // test two keys creation one after the other.
});

SPEC_END

