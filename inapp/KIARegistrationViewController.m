#import "KIARegistrationViewController.h"
#import "KIAUrl.h"

@implementation KIARegistrationViewController

UIView *_loadingView;

id<KIARegistrationViewControllerDelegate> delegate;

- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)aDelegate {
  if (self = [super init]) {
    delegate = aDelegate;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.frame];
  webview.delegate = self;
  NSURLRequest *nsrequest = [NSURLRequest requestWithURL:[KIAUrl registrationUrl]];
  [webview loadRequest:nsrequest];
  [self.view addSubview:webview];
  
  [self InitializeSpinner];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [_loadingView removeFromSuperview];
  if ([error code] != NSURLErrorCancelled && [delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [delegate klarnaRegistrationFailed:self];
  }
}

- (NSString *)title {
  return @"Payment Details";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [_loadingView removeFromSuperview];
}

- (void) InitializeSpinner {
  _loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
  _loadingView.center = self.view.center;
  _loadingView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
  _loadingView.layer.cornerRadius = 5;
  
  UIActivityIndicatorView *activityView= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  activityView.center = CGPointMake(_loadingView.frame.size.width / 2.0, 35);
  [activityView startAnimating];
  [_loadingView addSubview:activityView];
  
  UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 80, 30)];
  lblLoading.text = @"Loading...";
  lblLoading.textColor = [UIColor whiteColor];
  lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
  lblLoading.textAlignment = NSTextAlignmentCenter;
  [_loadingView addSubview:lblLoading];
  
  [self.view addSubview:_loadingView];
}


@end