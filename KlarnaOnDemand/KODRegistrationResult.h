#import <Foundation/Foundation.h>

/**
 *  The user's Klarna registration result, which includes the token used for making purchaces.
 */
@interface KODRegistrationResult : NSObject

/**
 *  The user's token, which is used for making orders.
 */
@property (strong, nonatomic) NSString *token;

/**
 *  The user's validated phone number.
 */
@property (strong, nonatomic) NSString *phoneNumber;

/**
 *  The user's registration details.
 */
@property (strong, nonatomic) NSDictionary *userDetails;

- (id)initWithToken:(NSString *)token andPhoneNumber:(NSString *)phoneNumber andUserDetails:(NSDictionary *)userDetails;

@end
