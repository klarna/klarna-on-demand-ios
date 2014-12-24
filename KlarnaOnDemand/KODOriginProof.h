#import <Foundation/Foundation.h>

@interface KODOriginProof : NSObject

+ (NSString *)generateWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken;

@end
