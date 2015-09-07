#import "AppDelegate.h"
#import "KODContext.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Set Klarna's API key.
  [KODContext setApiKey:@"test_d8324b98-97ce-4974-88de-eaab2fdf4f14"];
  [KODContext setButtonColor:[UIColor colorWithRed:0.12 green:0.45 blue:0.78 alpha:1.0]];
  [KODContext setLinkColor:[UIColor magentaColor]];
  return YES;
}

@end
