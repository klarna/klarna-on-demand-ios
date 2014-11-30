#import "KIARegistrationViewController.h"

@interface KIARegistrationViewController (Test)
- (void)cancelButtonPressed;
@end

SPEC_BEGIN(KIARegistrationViewControllerSpec)

describe(@"KIARegistrationViewControllerSpec", ^{
  
  it(@"should conform to UIWebViewDelegate protocol", ^ {
    [[[KIARegistrationViewController mock] should] conformToProtocol:@protocol(UIWebViewDelegate)];
  });
  
  it(@"should call .klarnaRegistrationCancelled when cancel button was pressed",^{
    id kiaRegistrationDelegate = [KWMock mockForProtocol:@protocol(KIARegistrationViewControllerDelegate)];
    KIARegistrationViewController *kiaRegistrationController = [[KIARegistrationViewController alloc] initWithDelegate:kiaRegistrationDelegate];
    [[[kiaRegistrationDelegate shouldEventually] receive] klarnaRegistrationCancelled:kiaRegistrationController];
    [kiaRegistrationController cancelButtonPressed];
  });
  
  it(@"should call .klarnaRegistrationFailed when web view failed to load",^{
    id kiaRegistrationDelegate = [KWMock mockForProtocol:@protocol(KIARegistrationViewControllerDelegate)];
    KIARegistrationViewController *kiaRegistrationController = [[KIARegistrationViewController alloc] initWithDelegate:kiaRegistrationDelegate];
    [[[kiaRegistrationDelegate shouldEventually] receive] klarnaRegistrationFailed:kiaRegistrationController];
    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });
  
});

SPEC_END