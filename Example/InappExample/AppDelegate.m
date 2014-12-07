#import "AppDelegate.h"
#import "KIAContext.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self setLanguage:@"en"];
  
  // Set Klarna's API key.
  [KIAContext setApiKey:@"test_29f612e8-1576-423f-80a8-679f354e4c89"];
  return YES;
}

- (void)setLanguage:(NSString *)language {
  [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:language, nil]
                                            forKey:@"AppleLanguages"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
