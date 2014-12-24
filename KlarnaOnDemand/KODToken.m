#import "KODToken.h"

@implementation KODToken

- (id)initWithToken:(NSString *)token {
  if (self = [super init]) {
    _token = token;
  }
  return self;
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[KODToken class]]) {
    KODToken *objectAsKiaToken = (KODToken *) object;
    return [objectAsKiaToken.token isEqualToString:_token];
  }
  return NO;
}

@end

