#import <Foundation/Foundation.h>


/**
 *  Defines the settings for Klarna's Registration Activity
 */
@interface KODRegistrationSettings : NSObject

/**
 *  Confirmed user data id parameter
 */
@property (strong, nonatomic) NSString *confirmedUserDataId;

/**
 *  Pre-fill phone number parameter
 */
@property (strong, nonatomic) NSString *prefillPhoneNumber;

/**
 * create a registration-settings object
 * @param prefillPhoneNumber Pre-fill phone number
 * @param confirmedUserDataId Confirmed user data id
 */
-(id) initWithPrefillPhoneNumber: (NSString *) prefillPhoneNumber andConfirmedUserDataId: (NSString *) confirmedUserDataId;

@end
