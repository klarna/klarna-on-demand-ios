#import <Foundation/Foundation.h>

/**
 *  Holds the user Klarna token, which is used for purchases.
 */
@interface KIAToken : NSObject

/**
 *  The user Klarna token, which is used for purchases.
 */
@property (weak, nonatomic) NSString *token;

- (id)initWithToken: (NSString *) aToken;

@end
