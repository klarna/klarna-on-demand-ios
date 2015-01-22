#import <Foundation/Foundation.h>

@interface KODCrypto : NSObject

@property (strong, nonatomic, readonly) NSString *publicKeyBase64Str;

+ (id)sharedKODCrypto;

- (NSString *)signWithData:(NSData *)plainData;

@end
