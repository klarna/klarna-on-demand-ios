#import "KIAPreferencesViewController.h"

@interface KIAPreferencesViewController ()

@end

@implementation KIAPreferencesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)AddWebView {
  UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.frame];
  webview.delegate = self;
  NSURLRequest *request = [NSURLRequest requestWithURL:[KIAUrl preferencesUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
  [webview loadRequest:request];
  [self.view addSubview:webview];
}


@end
