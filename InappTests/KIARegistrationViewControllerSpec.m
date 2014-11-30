#import "KIARegistrationViewController.h"

@interface KIARegistrationViewController (Test)
- (void)cancelButtonPressed;
@end

SPEC_BEGIN(KIARegistrationViewControllerSpec)

describe(@"KIARegistrationViewControllerSpec", ^{
  __block id kiaRegistrationDelegate;
  __block KIARegistrationViewController *kiaRegistrationController;
  
  beforeEach(^{
    kiaRegistrationDelegate = [KWMock mockForProtocol:@protocol(KIARegistrationViewControllerDelegate)];
    kiaRegistrationController = [[KIARegistrationViewController alloc] initWithDelegate:kiaRegistrationDelegate];
  });
  
  it(@"should conform to UIWebViewDelegate protocol", ^ {
    [[[KIARegistrationViewController mock] should] conformToProtocol:@protocol(UIWebViewDelegate)];
  });
  
  it(@"should call .klarnaRegistrationCancelled when cancel button was pressed",^{
    [[[kiaRegistrationDelegate shouldEventually] receive] klarnaRegistrationCancelled:kiaRegistrationController];
    
    [kiaRegistrationController cancelButtonPressed];
  });
  
  it(@"should call .klarnaRegistrationFailed when web view failed to load",^{
    [[[kiaRegistrationDelegate shouldEventually] receive] klarnaRegistrationFailed:kiaRegistrationController];
    
    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });
  
  it(@"should not call .klarnaRegistrationFailed when web view failed on NSURLErrorCancelled",^{
    [[[kiaRegistrationDelegate shouldNotEventually] receive] klarnaRegistrationFailed:kiaRegistrationController];
    
    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });
  
});

SPEC_END