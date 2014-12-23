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
    _delegate = delegate;
    _token = token;
  }
  return self;
}

- (id)init {
  NSAssert(NO, @"Initialize with -initWithDelegate:andToken:");
  return nil;
}

- (NSURL *)url {
  return [KODUrl preferencesUrlWithToken: _token];
}

- (NSString *)title {
  return [KODLocalization localizedStringForKey:@"PREFERENCES_TITLE"];
}

- (NSString *)dismissButtonLabelKey {
  return @"PREFERENCES_DISMISS_BUTTON_TEXT";
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [super webView:webView didFailLoadWithError:error];
  
  if (error.code != NSURLErrorCancelled && [_delegate respondsToSelector:@selector(klarnaPreferencesFailed:)])
  {
    [_delegate klarnaPreferencesFailed:self];
  }
}

- (void)dismissButtonPressed {
  if ([_delegate respondsToSelector:@selector(klarnaPreferencesClosed:)])
  {
    [_delegate klarnaPreferencesClosed:self];
  }
}

- (void)handleUserReadyEventWithPayload:(NSDictionary *)payload {
  NSURLRequest *request = [NSURLRequest requestWithURL:[self url]
                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                       timeoutInterval:60.0f];
  [self.webView loadRequest:request];
}

- (void)handleUserErrorEvent {
  if ([_delegate respondsToSelector:@selector(klarnaPreferencesFailed:)])
  {
    [_delegate klarnaPreferencesFailed:self];
  }
}


@end
