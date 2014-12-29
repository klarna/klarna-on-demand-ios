#import <Foundation/Foundation.h>

/**
 *  Holds the user's Klarna registration result, including the token which used for Klarna purchases.
 */
@interface KODRegistrationResult : NSObject

/**
 *  The user's token, which is used for making orders.
 */
@property (strong, nonatomic) NSString *token;

- (id)initWithToken:(NSString *)token;

@end
