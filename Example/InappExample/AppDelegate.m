#import "AppDelegate.h"
#import "KIAContext.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Set Klarna's API key.
  [KIAContext setApiKey:@"test_29f612e8-1576-423f-80a8-679f354e4c89"];
  self.window.tintColor = [UIColor colorWithRed:0.28 green:0.57 blue:0.86 alpha:1];
    
  return YES;
}

@end
