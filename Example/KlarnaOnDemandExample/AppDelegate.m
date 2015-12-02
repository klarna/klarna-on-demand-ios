#import "AppDelegate.h"
#import "KODContext.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Set Klarna's API key.
  [KODContext setApiKey:@"test_d8324b98-97ce-4974-88de-eaab2fdf4f14"];
  [KODContext setPreferredLocale:@"sv"];
  return YES;
}

@end
