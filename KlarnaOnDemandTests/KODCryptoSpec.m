#import <Foundation/Foundation.h>
#import "KODOriginProof.h"
#import "KODCrypto.h"
#import <Foundation/NSJSONSerialization.h>
#import "BDRSACryptor.h"
#import "BDError.h"
#import "NSString+Base64.h"
#import "KODSpecHelper.h"

SPEC_BEGIN(KODCryptoSpec)

beforeEach(^{
  [[NSBundle mainBundle] stub:@selector(bundleIdentifier) andReturn:@"bundle_identifier"];
});

describe(@".getSignatureWithText", ^{
  
  it(@"should calculate a valid signature", ^{
    BDRSACryptor *rsaCryptor = [[BDRSACryptor alloc] init];
    BDError *error = [[BDError alloc] init];
    [rsaCryptor setPrivateKey:@"-----BEGIN RSA PRIVATE KEY-----\nMIIBOgIBAAJBAK3h0RtywI11idN0CfZlyo1LhA/7ssmGN5Wl+qNdk+/d0xVpb50U\nWr1gdmaBkbYEsDj1EbaVtChA9tKtFMNw9PkCAwEAAQJANSQHYSkf2durJJmZFdmk\nHqyOjsfwqxA+2phgUh8eQDb8z5Bv5DYmgpDMI7wBzfYtJtS2j40/2Ium8VQgJp7P\nAQIhAN6X1HQCJhfVh5lAEjcsIlOiu+UrAB6P2zYouk24iUghAiEAx/p6ssSi12rK\nERMOcAzbLVIjYGi4CcGCU2HvyxW0sdkCICVuqPadSeSmLvhxkt6eWGNyMWDXe1yo\nWnfgH3xkdQmhAiEAlMRf1vG1eq+01vLoQK8vtg1ux9/fWVKdk04+R0REgjECIACX\njuUhQyJKyGGEF+2NOnEix/6Eo+gM6rkyaIfDC3Nb\n-----END RSA PRIVATE KEY-----\n" tag:@"bundle_identifier.privateKey.kia" error:error];
    
    NSString *signature = [[KODCrypto sharedKODCrypto] getSignatureWithData:[@"my_data" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[signature should] equal:@"Qx4Lcud2ECP+cJhg9zYAUFuc9WNoB141W3Chxok5cI7xG44xkxmWn27heccUBvS8G/rP2P1U1YE8DMEf/PhQKw=="];
  });
});

describe(@".init", ^{
  
  beforeEach(^{
    [KODSpecHelper resetKeychain];
    (void) [[KODCrypto alloc] init];
  });
  
  it(@"should create a private key in the keychain with the correct tag", ^{
    [[theValue([KODSpecHelper tagExistsInKeychain:@"bundle_identifier.privateKey.kia"]) should] equal: theValue(YES)];
  });
  
  it(@"should create a public key in the keychain with the correct tag", ^{
    [[theValue([KODSpecHelper tagExistsInKeychain:@"bundle_identifier.publicKey.kia"]) should] equal: theValue(YES)];
  });
  
  it(@"should return same key on two consecutive calls", ^{
    NSString *firstPrivateKey = [KODSpecHelper privateKeyForTag:@"bundle_identifier.privateKey.kia"];
    NSString *firstPublicKey = [KODSpecHelper publicKeyForTag:@"bundle_identifier.publicKey.kia"];
    
    (void) [[KODCrypto alloc] init];
    NSString *secondPrivateKey = [KODSpecHelper privateKeyForTag:@"bundle_identifier.privateKey.kia"];
    NSString *secondPublicKey = [KODSpecHelper publicKeyForTag:@"bundle_identifier.publicKey.kia"];
    
    [[firstPrivateKey should] equal:secondPrivateKey];
    [[firstPublicKey should] equal:secondPublicKey];
  });
  
  it(@"should generate a different key after existing keys are deleted", ^{
    NSString *firstPrivateKey = [KODSpecHelper privateKeyForTag:@"bundle_identifier.privateKey.kia"];
    NSString *firstPublicKey = [KODSpecHelper publicKeyForTag:@"bundle_identifier.publicKey.kia"];
    
    [KODSpecHelper resetKeychain];
    (void) [[KODCrypto alloc] init];
    NSString *secondPrivateKey = [KODSpecHelper privateKeyForTag:@"bundle_identifier.privateKey.kia"];
    NSString *secondPublicKey = [KODSpecHelper publicKeyForTag:@"bundle_identifier.publicKey.kia"];
    
    [[firstPrivateKey shouldNot] equal:secondPrivateKey];
    [[firstPublicKey shouldNot] equal:secondPublicKey];
  });
  
});

SPEC_END

