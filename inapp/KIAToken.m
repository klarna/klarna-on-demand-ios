#import "KIAToken.h"

@implementation KIAToken

- (id)initWithToken:(NSString *)token {
  if (self = [super init]) {
    _token = token;
  }
  return self;
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[KIAToken class]]) {
    KIAToken *objectAsKiaToken = (KIAToken *) object;
    return [objectAsKiaToken.token isEqualToString:_token];
  }
  return NO;
}

@end

