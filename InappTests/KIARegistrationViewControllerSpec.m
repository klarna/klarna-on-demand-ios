#import "KIARegistrationViewController.h"
/*
@interface KIARegistrationViewController (Testing)

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
@end
*/
SPEC_BEGIN(KIARegistrationViewControllerSpec)

describe(@"KIARegistrationViewControllerSpec", ^{
  it(@"should ...",^{
    id kiaRegistrationDelegate = [KWMock mockForProtocol:@protocol(KIARegistrationViewControllerDelegate)];
    KIARegistrationViewController *kiaRegistrationController = [[KIARegistrationViewController alloc] initWithDelegate:kiaRegistrationDelegate];
    [[[kiaRegistrationDelegate shouldEventually] receive] klarnaRegistrationFailed:kiaRegistrationController];
    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });
});

SPEC_END