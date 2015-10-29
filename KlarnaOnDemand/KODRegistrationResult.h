#import <Foundation/Foundation.h>

/**
 *  The user's Klarna registration result, which includes the token used for making purchaces.
 */
@interface KODRegistrationResult : NSObject

/**
 *  The user's token, which is used for making orders.
 */
@property (strong, nonatomic) NSString *token;

- (id)initWithToken:(NSString *)token;

@end
