#import "KODRegistrationResult.h"

@implementation KODRegistrationResult

- (id)initWithToken:(NSString *)token {
  if (self = [super init]) {
    self.token = token;
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
    return [objectAsKODRegistrationResult.token isEqualToString:self.token];
  }
  return NO;
}

@end

