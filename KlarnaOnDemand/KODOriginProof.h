#import <Foundation/Foundation.h>

/**
 *  Assists in creating origin proofs that allow performing secure purchases.
 */
@interface KODOriginProof : NSObject

/**
 *  Generates an origin proof that can be used to verify the details of the purchase.
 *
 *  @param amount    Purchase's total amount in "cents"
 *  @param currency  Currency used in this purchase ("SEK", "EUR", or other <a href="http://en.wikipedia.org/wiki/ISO_4217">ISO 4217 codes</a>)
 *  @param userToken Token identifying the user making the purchase
 *
 *  @return An origin proof that matches the purchase details and the device that issued the purchase.
 */
- (id)initWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken;

/**
 *  Generates an origin proof that can be used to verify the details of the purchase.
 *
 *  @param amount             Purchase's total amount in "cents"
 *  @param currency           Currency used in this purchase ("SEK", "EUR", or other <a href="http://en.wikipedia.org/wiki/ISO_4217">ISO 4217 codes</a>)
 *  @param userToken          Token identifying the user making the purchase
 *  @param externalPrivateKey Private key to be used for encrypting the origin-proof.
 *
 *  @return An origin proof that matches the purchase details and the device that issued the purchase.
 */
- (id)initWithAmount:(int)amount currency:(NSString *)currency userToken:(NSString *)userToken externalPrivateKey:(SecKeyRef)externalPrivateKey;

/**
 *  Returns a textual representation of the origin proof that needs to be sent along with the purchase for it to succeed.
 *
 *  @return A textual representation of the origin proof that needs to be sent along with the purchase for it to succeed.
 */
- (NSString *)description;

@end
