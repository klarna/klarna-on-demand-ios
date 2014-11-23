#import "KIARegistrationViewController.h"
#import "KIAUrl.h"

@interface KIARegistrationViewController ()

@end

@implementation KIARegistrationViewController

id<KIARegistrationViewControllerDelegate> delegate;

- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)aDelegate {
    if (self = [super init]) {
        delegate = aDelegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL:[KIAUrl registrationUrl]];
    [webview loadRequest:nsrequest];
    [self.view addSubview:webview];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
         
}

@end
