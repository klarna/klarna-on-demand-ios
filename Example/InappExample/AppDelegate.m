#import "AppDelegate.h"
#import "KODContext.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Set Klarna's API key.
  [KODContext setApiKey:@"test_29f612e8-1576-423f-80a8-679f354e4c89"];
  return YES;
}

@end
