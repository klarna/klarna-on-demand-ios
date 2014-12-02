#import <Foundation/Foundation.h>

@interface KIAToken : NSObject

@property (weak, nonatomic) NSString *token;

- (id)initWithToken: (NSString *) aToken;

@end
