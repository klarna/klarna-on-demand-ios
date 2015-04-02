#import <Foundation/Foundation.h>

@interface KODRegistrationSettings : NSObject

@property (strong, nonatomic) NSString *confirmedUserDataId;
@property (strong, nonatomic) NSString *prefillPhoneNumber;

-(id) initWithPrefillPhoneNumber: (NSString *) prefillPhoneNumber andConfirmedUserDataId: (NSString *) confirmedUserDataId;

@end
