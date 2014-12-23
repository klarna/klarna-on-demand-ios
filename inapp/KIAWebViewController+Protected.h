#import "KIAWebViewController.h"

@interface KIAWebViewController (Protected)

- (NSURL *)url;
- (void)handleUserReadyEventWithPayload:(NSDictionary *)payload;
- (void)handleUserErrorEvent;
- (void)dismissButtonPressed;
- (NSString *)dismissButtonLabelKey;

@end
