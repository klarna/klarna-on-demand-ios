#import <Foundation/Foundation.h>

/**
 *  Assists in creating origin proofs that allow performing secure purchases.
 */
@interface KODOriginProof : NSObject

/**
 *  Generates an origin proof that matches the details of the purchase it will be used to verify.
 *
 *  @param amount    The purchase's total amount in "cents"
 *  @param currency  The currency used in this purchase ("SEK", "EUR", or other <a href="http://en.wikipedia.org/wiki/ISO_4217">ISO 4217 codes</a>)
 *  @param userToken Token identifying the user making the purchase
 *
 *  @return An origin proof that needs to be sent along with the purchase for it to succeed.
 */
- (id)initWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken;

/**
 *  Generates an origin proof NString that matches the details of the purchase it will be used to verify.
 *
 *  @return An origin proof NString that needs to be sent along with the purchase for it to succeed.
 */
- (NSString *)description;

@end
