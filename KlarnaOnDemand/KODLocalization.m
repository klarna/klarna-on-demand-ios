#import "KODLocalization.h"

@implementation KODLocalization

+ (NSBundle*)KODBundle {
  static NSBundle *bundle = nil;
  
  if (!bundle) {
    NSString *bundlePath = [NSBundle.mainBundle pathForResource:@"KOD" ofType:@"bundle"];
    if (!bundlePath) {
      bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"KOD" ofType:@"bundle"];
    }
    bundle = [NSBundle bundleWithPath:bundlePath];
  }
  return bundle;
}

+ (NSString *)localizedStringForKey:(NSString *)key {
  return NSLocalizedStringFromTableInBundle(key, @"localization", [self KODBundle], @"");
}

@end
