#import "KIAToken.h"

@implementation KIAToken

- (id)initWithToken: (NSString *) aToken{
  if (self = [super init]) {
    _token = aToken;
  }
  return self;
}

@end

