#import <Foundation/Foundation.h>

/**
 *  Holds the user's Klarna registration result, including the token which used for Klarna purchases.
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
