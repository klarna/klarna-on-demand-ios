#import "KODUrl.h"
#import <UIKit/UIKit.h>
#import <JockeyJS/Jockey.h>
#import "KODContext.h"
#import "KODLocalization.h"
#import "KODWebViewController+Protected.h"

@implementation KODWebViewController

NSString *const JockeyUserReady = @"userReady";
NSString *const JockeyUserError =  @"userError";

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self addWebView];
  
  [self registerJockeyEvents];
  
  [self addHUD];
  
  [self addDismissButton];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:[self url]
                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                       timeoutInterval:60.0f];
  [self.webView loadRequest:request];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  
  [self unregisterJockeyCallbacks];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  return [Jockey webView:webView withUrl:[request URL]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self removeHUDIfExists];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [self removeHUDIfExists];
  
  NSLog(@"Klarna web view failed with the following error: %@", [error description]);
}

- (void)addDismissButton {
  self.navigationItem.hidesBackButton = YES;
  
  NSString *dismissButtonTitle = [KODLocalization localizedStringForKey:[self dismissButtonLabelKey]];
  if(dismissButtonTitle == nil) {
    dismissButtonTitle = [KODLocalization localizedStringForKey:@"PREFERENCES_DEFAULT_DISMISS_BUTTON_TEXT"];
  }
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:dismissButtonTitle
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismissButtonPressed)];
}

- (void)addWebView {
  self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
  self.webView.delegate = self;
  [self.view addSubview:_webView];
}

- (void)addHUD {
  self.HUDView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
  self.HUDView.center = self.view.center;
  self.HUDView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
  self.HUDView.layer.cornerRadius = 5;
  
  UIActivityIndicatorView *activityView= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  activityView.center = CGPointMake(self.HUDView.frame.size.width / 2.0, 35);
  [activityView startAnimating];
  [self.HUDView addSubview:activityView];
  
  UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 80, 30)];
  lblLoading.text = [KODLocalization localizedStringForKey:@"LOADING_SPINNER"];
  lblLoading.textColor = [UIColor whiteColor];
  lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
  lblLoading.textAlignment = NSTextAlignmentCenter;
  [self.HUDView addSubview:lblLoading];
  
  [self.view addSubview:self.HUDView];
}

- (void)removeHUDIfExists {
  [self.HUDView removeFromSuperview];
}

- (void)registerJockeyEvents {
  [Jockey on:JockeyUserReady perform:^(NSDictionary *payload) {
    [self handleUserReadyEventWithPayload: payload];
  }];
  
  [Jockey on:JockeyUserError perform:^(NSDictionary *payload) {
    [self handleUserErrorEvent];
  }];
}

- (void)unregisterJockeyCallbacks {
  [Jockey off:JockeyUserReady];
  [Jockey off:JockeyUserError];
}


@end
