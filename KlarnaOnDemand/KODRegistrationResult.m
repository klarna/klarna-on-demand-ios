#import "KODRegistrationResult.h"

@implementation KODRegistrationResult

- (id)initWithToken:(NSString *)token andPhoneNumber:(NSString *)phoneNumber andUserDetails:(NSDictionary *)userDetails {
  if (self = [super init]) {
    self.token = token;
    self.phoneNumber = phoneNumber;
    self.userDetails = userDetails;
  }
  return self;
}

- (id)init {
  NSAssert(NO, @"Initialize with -initWithToken:");
  return nil;
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[KODRegistrationResult class]]) {
    KODRegistrationResult *objectAsKODRegistrationResult = (KODRegistrationResult *) object;
    return [objectAsKODRegistrationResult.token isEqualToString:self.token] &&
    [objectAsKODRegistrationResult.phoneNumber isEqualToString:self.phoneNumber] &&
    [ objectAsKODRegistrationResult.userDetails isEqualToDictionary:self.userDetails];
  }
  return NO;
}

@end

