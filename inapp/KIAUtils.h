#import <Foundation/Foundation.h>

#define USER_TOKEN_KEY @"klarna_user_token"

@interface KIAUtils : NSObject

+ (void)saveUserToken:(NSString *)userToken;

+ (NSString *)getUserToken;

@end
