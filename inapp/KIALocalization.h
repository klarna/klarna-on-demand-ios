#import <Foundation/Foundation.h>

/**
 *  Handles localization language.
 *  Currently support English and Swedish.
 *  The translation reside in KIA bundle localization table.
 *  KIALocalization doesn't support code defualts, so please add new key to all locales.
 */
@interface KIALocalization : NSObject

/**
 *  Return Localized string for key.
 *
 *  @param key in the localization table.
 *
 *  @return Localized string.
 */
+ (NSString *)localizedStringForKey:(NSString *)key;

@end
