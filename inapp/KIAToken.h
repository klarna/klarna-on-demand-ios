#import <Foundation/Foundation.h>

/**
 *  Holds the user Klarna token, which is used for making orders.
 */
@interface KIAToken : NSObject

/**
 *  The user's token, which is used for making orders.
 */
@property (weak, nonatomic) NSString *token;

- (id)initWithToken: (NSString *) aToken;

@end
