#import "KODHelpers.h"
#import <UIKit/UIKit.h>

@implementation KODHelpers

+ (NSString *)hexStringFromColor:(UIColor *)color {
  if (color == nil) {
    return nil;
  }
  CGColorSpaceModel colorSpace = CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor));
  const CGFloat *components = CGColorGetComponents(color.CGColor);
  
  CGFloat r, g, b;
  
  if (colorSpace == kCGColorSpaceModelMonochrome) {
    r = components[0];
    g = components[0];
    b = components[0];
  }
  else if (colorSpace == kCGColorSpaceModelRGB) {
    r = components[0];
    g = components[1];
    b = components[2];
  }
  
  return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
          lroundf(r * 255),
          lroundf(g * 255),
          lroundf(b * 255)];
}

@end
