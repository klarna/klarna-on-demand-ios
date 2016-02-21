#import <Foundation/Foundation.h>
#import "BDRSACryptorKeyPair.h"

@interface KODCrypto : NSObject

@property (strong, nonatomic, readonly) NSString *publicKeyBase64Str;

+ (id)sharedKODCrypto;

- (NSString *)signWithData:(NSData *)plainData;

+ (NSString *)signWithData:(NSData *)plainData andPrivateKey:(SecKeyRef)privateKey;

@end
