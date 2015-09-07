#import "KODHelpers.h"
#import <UIKit/UIKit.h>

SPEC_BEGIN(KODHelpersSpec)

describe(@"hexStringFromColor", ^{
  it(@"returns nil when the color is nil", ^{
    [[KODHelpers hexStringFromColor:nil] shouldBeNil];
  });
  
  it(@"returns a valid hex string for valid colors", ^{
    static NSString *colorKey = @"color";
    static NSString *colorHex = @"hex";
    NSArray *colorsAndResults = @[@{colorKey: [UIColor blackColor], colorHex: @"#000000"},
                                  @{colorKey: [UIColor whiteColor], colorHex: @"#FFFFFF"},
                                  @{colorKey: [UIColor colorWithRed:78.0/255.0 green:255.0/255.0 blue:161.0/255.0 alpha:1.0], colorHex: @"#4EFFA1"}];
    
    for(NSDictionary *color in colorsAndResults) {
      [[[KODHelpers hexStringFromColor:color[colorKey]] should] equal:color[colorHex]];
    }
  });
  
  it(@"ignores the alpha channel", ^{
    static NSString *hex = @"#FF00FF";
    int red = 1;
    int green = 0;
    int blue = 1;
    NSArray *alphas = @[@0.0, @0.5];
    
    for(NSNumber *alpha in alphas) {
      UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:[alpha floatValue]];
      [[[KODHelpers hexStringFromColor:color] should] equal:hex];
    }
  });
  
  it(@"raises an exception when a wrong object is sent", ^{
    UIColor *notAColor = (UIColor *)@"";
    
    [[theBlock(^{
      [KODHelpers hexStringFromColor:notAColor];
    }) should] raise];
  });
});

SPEC_END