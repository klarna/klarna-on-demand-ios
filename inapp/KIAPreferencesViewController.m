#import "KIAPreferencesViewController.h"
#import "KIAUrl.h"
#import "KIALocalization.h"

@interface KIAPreferencesViewController ()
@property(strong, nonatomic) NSString *token;
@end

@implementation KIAPreferencesViewController

- (id)initWithToken: (NSString *) token {
  self = [super init];
  if (self) {
    _token = token;
  }
  return self;
}

-(id)init {
  NSAssert(NO, @"Initialize with -initWithToken");
  return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSURL *)Url {
  return [KIAUrl preferencesUrlWithToken: _token];
}

- (NSString *)title {
  return [KIALocalization localizedStringForKey:@"PREFERENCES_TITLE"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [super webView:webView didFailLoadWithError:error];
  
  //TODO: additional handling?
}

- (void)cancelButtonPressed {
  //TODO: handling.
}

- (void)handleUserReadyEventWithPayload: (NSDictionary *)payload {
  NSURLRequest *request = [NSURLRequest requestWithURL:[self Url]
                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                       timeoutInterval:60.0f];
  [self.webView loadRequest:request];
}

- (void)handleUserErrorEvent {
  //TODO: handling.
}


@end
