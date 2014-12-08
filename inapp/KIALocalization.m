#import "KIALocalization.h"

@implementation KIALocalization

+ (NSBundle*)KIABundle {
  NSString *bundlePath = [NSBundle.mainBundle pathForResource:@"KIA" ofType:@"bundle"];
  if (!bundlePath) {
    bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"KIA" ofType:@"bundle"];
  }
  return [NSBundle bundleWithPath:bundlePath];
}

+ (NSString *)localizedStringForKey:(NSString *)key {
  return NSLocalizedStringFromTableInBundle(key, @"localization", [self KIABundle], @"");
}

@end
