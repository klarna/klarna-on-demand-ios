#import "KIARegistrationViewController.h"
#import "KIAUrl.h"
#import "Jockey.h"
#import "KIAContext.h"
#import "KIAUtils.h"

#define JOCKEY_USER_READY @"userReady"
#define JOCKEY_USER_ERROR @"userError"

@implementation KIARegistrationViewController

UIView *_spinnerView;

id<KIARegistrationViewControllerDelegate> delegate;

- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)aDelegate {
  if (self = [super init]) {
    delegate = aDelegate;
  }
  return self;
}

- (NSString *)title {
  return @"Payment Details";
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed)];
  
  [self AddWebView];
  
  [self registerJockeyEvents];
  
  [self AddSpinner];
  
}

- (void)AddWebView {
  UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.frame];
  webview.delegate = self;
  NSURLRequest *request = [NSURLRequest requestWithURL:[KIAUrl registrationUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
  [webview loadRequest:request];
  [self.view addSubview:webview];
}

- (void)AddSpinner {
  _spinnerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
  _spinnerView.center = self.view.center;
  _spinnerView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
  _spinnerView.layer.cornerRadius = 5;
  
  UIActivityIndicatorView *activityView= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  activityView.center = CGPointMake(_spinnerView.frame.size.width / 2.0, 35);
  [activityView startAnimating];
  [_spinnerView addSubview:activityView];
  
  UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 80, 30)];
  lblLoading.text = @"Loading...";
  lblLoading.textColor = [UIColor whiteColor];
  lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
  lblLoading.textAlignment = NSTextAlignmentCenter;
  [_spinnerView addSubview:lblLoading];
  
  [self.view addSubview:_spinnerView];
}

- (void)RemoveSpinnerIfExists {
  [_spinnerView removeFromSuperview];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  return [Jockey webView:webView withUrl:[request URL]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [self RemoveSpinnerIfExists];
  
  NSLog(@"Klarna registration web view failed with the following error: %@", [error description]);
  
  if ([error code] != NSURLErrorCancelled && [delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [delegate klarnaRegistrationFailed:self];
  }
}

- (void)cancelButtonPressed {
  if ([delegate respondsToSelector:@selector(klarnaRegistrationCancelled:)])
  {
    [delegate klarnaRegistrationCancelled:self];
  }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self RemoveSpinnerIfExists];
}

- (void)registerJockeyEvents {
  [Jockey on:JOCKEY_USER_READY perform:^(NSDictionary *payload) {
    [self handleUserReadyEventWithPayload: payload];
  }];
  
  [Jockey on:JOCKEY_USER_ERROR perform:^(NSDictionary *payload) {
    [self handleUserErrorEvent];
  }];
}

- (void) handleUserReadyEventWithPayload: (NSDictionary *)payload {
  NSString *token = payload[@"userToken"];
  if(token)
    [KIAUtils saveUserToken:token];
  if ([delegate respondsToSelector:@selector(klarnaRegistrationController:didFinishWithUserToken:)])
  {
    [delegate klarnaRegistrationController:self didFinishWithUserToken:[[KIAToken alloc] initWithToken: token]];
  }
}

- (void) handleUserErrorEvent {
  if ([delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [delegate klarnaRegistrationFailed:self];
  }
}

- (void)viewDidDisappear:(BOOL)animated {
  [self unregisterJockeyCallbacks];
}

- (void)unregisterJockeyCallbacks{
  [Jockey off:JOCKEY_USER_READY];
  [Jockey off:JOCKEY_USER_ERROR];
}

@end