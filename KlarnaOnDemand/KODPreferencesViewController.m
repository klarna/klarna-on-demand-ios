#import "KODPreferencesViewController.h"
#import "KODUrl.h"
#import "KODLocalization.h"

@interface KODPreferencesViewController ()

@property(strong, nonatomic) NSString *token;
@property (weak, nonatomic) id<KODPreferencesViewControllerDelegate> delegate;

@end

@implementation KODPreferencesViewController

- (id)initWithDelegate:(id<KODPreferencesViewControllerDelegate>)delegate andToken:(NSString *)token {
  self = [super init];
  if (self) {
    self.delegate = delegate;
    self.token = token;
  }
  return self;
}

- (id)init {
  NSAssert(NO, @"Initialize with -initWithDelegate:andToken:");
  return nil;
}

- (NSURL *)url {
  return [KODUrl preferencesUrlWithToken: self.token];
}

- (NSString *)title {
  return [KODLocalization localizedStringForKey:@"PREFERENCES_TITLE"];
}

- (NSString *)dismissButtonLabelKey {
  return @"PREFERENCES_DISMISS_BUTTON_TEXT";
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [super webView:webView didFailLoadWithError:error];
  
  if (error.code != NSURLErrorCancelled && [self.delegate respondsToSelector:@selector(klarnaPreferencesFailed:)])
  {
    [self.delegate klarnaPreferencesFailed:self];
  }
}

- (void)dismissButtonPressed {
  if ([self.delegate respondsToSelector:@selector(klarnaPreferencesClosed:)]) {
    [self.delegate klarnaPreferencesClosed:self];
  }
}

- (void)handleUserReadyEventWithPayload:(NSDictionary *)payload {
  NSURLRequest *request = [NSURLRequest requestWithURL:[self url]
                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                       timeoutInterval:60.0f];
  [self.webView loadRequest:request];
}

- (void)handleUserErrorEvent {
  if ([self.delegate respondsToSelector:@selector(klarnaPreferencesFailed:)]) {
    [self.delegate klarnaPreferencesFailed:self];
  }
}


@end
