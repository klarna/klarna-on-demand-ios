#import "KODLocalization.h"
#import "KODContext.h"

@interface KODLocalization (Protected)

+ (NSBundle*)KODBundle;

@end

SPEC_BEGIN(KODLocalizationSpec)

describe(@".KODBundle", ^{
  
  it(@"should return the dfault bundle when preferred locale is same as locale from main bundle", ^{
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"en"]];
    [[KODContext class] stub:@selector(getPreferredLocale) andReturn:@"en"];
    
    [[[[[KODLocalization KODBundle] bundlePath] lastPathComponent] should] equal:@"KOD.bundle"];
  });
  
  it(@"should return the dfault bundle when preferred locale does not exist in bundle", ^{
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"en"]];
    [[KODContext class] stub:@selector(getPreferredLocale) andReturn:@"he"];
    
    [[[[[KODLocalization KODBundle] bundlePath] lastPathComponent] should] equal:@"KOD.bundle"];
  });
  
  it(@"should return the dfault bundle when preferred locale is different than locale from main bundle", ^{
    [[NSBundle mainBundle] stub:@selector(preferredLocalizations) andReturn:@[@"en"]];
    [[KODContext class] stub:@selector(getPreferredLocale) andReturn:@"sv"];
    
    [[[[[KODLocalization KODBundle] bundlePath] lastPathComponent] should] equal:@"sv.lproj"];
  });
});

SPEC_END
