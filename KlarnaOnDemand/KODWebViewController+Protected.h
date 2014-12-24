#import "KODWebViewController.h"

@interface KODWebViewController (Protected)

- (NSURL *)url;
- (void)handleUserReadyEventWithPayload:(NSDictionary *)payload;
- (void)handleUserErrorEvent;
- (void)dismissButtonPressed;
- (NSString *)dismissButtonLabelKey;

@end
