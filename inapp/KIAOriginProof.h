#import <Foundation/Foundation.h>

@interface KIAOriginProof : NSObject

- (NSString *)generateWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken;

@end
