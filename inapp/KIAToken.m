#import "KIAToken.h"

@implementation KIAToken

- (id)initWithToken: (NSString *) aToken{
  if (self = [super init]) {
    _token = aToken;
  }
  return self;
}

- (BOOL)isEqual:(id)object{
  if([object isKindOfClass:[KIAToken class]]) {
    KIAToken *objectAsKiaToken = (KIAToken *) object;
    return [objectAsKiaToken.token isEqualToString:_token];
  }
  return NO;
}

@end

