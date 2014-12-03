#import "KIAUtils.h"

@implementation KIAUtils

+ (NSString *)getUserToken {
  return [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN_KEY];
}

+ (void)saveUserToken:(NSString *)userToken {
  [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:USER_TOKEN_KEY];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
