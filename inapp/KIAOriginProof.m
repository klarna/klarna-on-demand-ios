#import "KIAOriginProof.h"
#import "KIACrypto.h"

@implementation KIAOriginProof

- (NSString *)generateWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken {
  
  return [[KIACrypto sharedKIACrypto] getSignatureWithText:@"blaaa"];
}

@end
