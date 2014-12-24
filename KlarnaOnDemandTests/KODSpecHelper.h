#import <Foundation/Foundation.h>

@interface KODSpecHelper : NSObject

+ (void)resetKeychain;
+ (BOOL)tagExistsInKeychain:(NSString *)tag;
+ (NSString *)privateKeyForTag:(NSString *)tag;
+ (NSString *)publicKeyForTag:(NSString *)tag;

@end
