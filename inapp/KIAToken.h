#import <Foundation/Foundation.h>

/**
 *  Holds the user's Klarna token, which is used for making orders.
 */
@interface KIAToken : NSObject

/**
 *  The user's token, which is used for making orders.
 */
@property (strong, nonatomic) NSString *token;

- (id)initWithToken:(NSString *)token;

@end
