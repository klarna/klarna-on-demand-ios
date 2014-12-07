#import "KIALocalization.h"

@implementation KIALocalization

+ (NSBundle*)KIABundle {
  static NSBundle *bundle = nil;
  
  if (!bundle) {
    NSString *bundlePath = [NSBundle.mainBundle pathForResource:@"KIA" ofType:@"bundle"];
    bundle = [NSBundle bundleWithPath:bundlePath];
  }
  return bundle;
}

+ (NSString *)localizedStringForKey:(NSString *)key {
  return NSLocalizedStringFromTableInBundle(key, @"localization", [self KIABundle], @"");
}

@end
