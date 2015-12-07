#import "KODLocalization.h"
#import "KODContext.h"

@implementation KODLocalization

+ (NSBundle*)KODBundle {
  static NSBundle *bundle = nil;
  static NSString *locale = nil;
  
  if (!bundle || locale != [KODContext getPreferredLocale]) {
    locale = [KODContext getPreferredLocale];
    NSString *bundlePath = [NSBundle.mainBundle pathForResource:@"KOD" ofType:@"bundle"];
    if (!bundlePath) {
      bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"KOD" ofType:@"bundle"];
    }
    bundle = [NSBundle bundleWithPath:bundlePath];
    
    if (locale != KODDeviceLocale) {
      bundlePath = [bundle pathForResource:@"localization" ofType:@"strings" inDirectory:nil forLocalization:locale];
      if (bundlePath) {
        bundle = [NSBundle bundleWithPath:[bundlePath stringByDeletingLastPathComponent]];
      }
    }
  }

  return bundle;
}

+ (NSString *)localizedStringForKey:(NSString *)key {
  return NSLocalizedStringFromTableInBundle(key, @"localization", [self KODBundle], @"");
}

@end
