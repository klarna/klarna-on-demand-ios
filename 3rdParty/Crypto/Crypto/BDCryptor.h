//
//  Created by Patrick Hogan on 10/12/12.
//


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Forward Declarations
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@class BDError;


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface BDCryptor : NSObject

- (NSString *)encrypt:(NSString *)plainText
                  key:(NSString *)key
                error:(BDError *)error;

- (NSString *)decrypt:(NSString *)cipherText
                  key:(NSString *)key
                error:(BDError *)error;

@end