#import "KODWebViewController.h"

@interface KODWebViewController (Protected)

- (NSURL *)url;
- (void)handleUserReadyEventWithPayload:(NSDictionary *)payload;
- (void)handleUserErrorEventWithPayload:(NSDictionary *)payload;
- (void)dismissButtonPressed;
- (NSString *)dismissButtonLabelKey;

@end
