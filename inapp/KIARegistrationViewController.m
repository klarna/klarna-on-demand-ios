#import "KIARegistrationViewController.h"
#import "KIAUrl.h"
#import "Jockey.h"
#import "KIAContext.h"
#import "KIALocalization.h"

#define JOCKEY_USER_READY @"userReady"
#define JOCKEY_USER_ERROR @"userError"

@interface KIARegistrationViewController ()

@property (nonatomic, weak) id<KIARegistrationViewControllerDelegate> delegate;
@property (strong, nonatomic) UIView *HUDView;

@end

@implementation KIARegistrationViewController

- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)delegate {
  self = [super init];
  if (self) {
    _delegate = delegate;
  }
  return self;
}

-(id) init {
  NSAssert(NO, @"Initialize with -initWithDelegate");
  return nil;
}

- (NSString *)title {
  return [KIALocalization localizedStringForKey:@"REGISTRATION_TITLE"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[KIALocalization localizedStringForKey:@"REGISTRATION_NAV_BUTTON"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(cancelButtonPressed)];
  
  [self AddWebView];
  
  [self registerJockeyEvents];
  
  [self AddHUD];
  
}

- (void)AddWebView {
  UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.frame];
  webview.delegate = self;
  NSURLRequest *request = [NSURLRequest requestWithURL:[KIAUrl registrationUrl]
                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                       timeoutInterval:60.0f];
  [webview loadRequest:request];
  [self.view addSubview:webview];
}

- (void)AddHUD {
  _HUDView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
  _HUDView.center = self.view.center;
  _HUDView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
  _HUDView.layer.cornerRadius = 5;
  
  UIActivityIndicatorView *activityView= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  activityView.center = CGPointMake(_HUDView.frame.size.width / 2.0, 35);
  [activityView startAnimating];
  [_HUDView addSubview:activityView];
  
  UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 80, 30)];
  lblLoading.text = [KIALocalization localizedStringForKey:@"LOADING_SPINNER"];
  lblLoading.textColor = [UIColor whiteColor];
  lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
  lblLoading.textAlignment = NSTextAlignmentCenter;
  [_HUDView addSubview:lblLoading];
  
  [self.view addSubview:_HUDView];
}

- (void)RemoveHUDIfExists {
  [_HUDView removeFromSuperview];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  return [Jockey webView:webView withUrl:[request URL]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [self RemoveHUDIfExists];
  
  NSLog(@"Klarna registration web view failed with the following error: %@", [error description]);
  
  if ([error code] != NSURLErrorCancelled && [_delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [_delegate klarnaRegistrationFailed:self];
  }
}

- (void)cancelButtonPressed {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationCancelled:)])
  {
    [_delegate klarnaRegistrationCancelled:self];
  }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self RemoveHUDIfExists];
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
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationController:didFinishWithUserToken:)])
  {
    [_delegate klarnaRegistrationController:self didFinishWithUserToken:[[KIAToken alloc] initWithToken: payload[@"userToken"]]];
  }
}

- (void) handleUserErrorEvent {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [_delegate klarnaRegistrationFailed:self];
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