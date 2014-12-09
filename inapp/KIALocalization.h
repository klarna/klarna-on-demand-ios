#import <Foundation/Foundation.h>

/**
 *  Handles localization.
 */
@interface KIALocalization : NSObject

/**
 *  Returns a localized string for a specified key.
 *
 *  @param localization key.
 *
 *  @return Localized string.
 */
+ (NSString *)localizedStringForKey:(NSString *)key;

@end
