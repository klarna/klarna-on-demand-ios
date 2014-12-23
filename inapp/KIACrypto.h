#import <Foundation/Foundation.h>

@interface KIACrypto : NSObject

@property (strong, nonatomic, readonly) NSString *publicKeyBase64Str;

+ (id)sharedKIACrypto;

- (NSString *)getSignatureWithData:(NSData *)plainData;

@end
