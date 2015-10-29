#import "KODRegistrationSettings.h"

@implementation KODRegistrationSettings

-(id) initWithPrefillPhoneNumber: (NSString *) prefillPhoneNumber andConfirmedUserDataId: (NSString *) confirmedUserDataId {
  self = [super init];
  if (self) {
    self.confirmedUserDataId = confirmedUserDataId;
    self.prefillPhoneNumber = prefillPhoneNumber;
  }
  return self;
}
@end
