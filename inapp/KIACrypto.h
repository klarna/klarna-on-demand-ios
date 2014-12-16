#import <Foundation/Foundation.h>

@interface KIACrypto : NSObject

@property (strong, nonatomic, readonly) NSString *publicKeyBase64Str;

+ (id)sharedKIACrypto;

- (NSString *)getSignatureWithText:(NSString *)plainText;

@end
