#import "KIARegistrationViewController.h"
#import "Jockey.h"
#import "KIAContext.h"
#import "KIAUtils.h"

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
    [[[kiaRegistrationDelegate should] receive] klarnaRegistrationCancelled:kiaRegistrationController];
    
    [kiaRegistrationController cancelButtonPressed];
  });
  
  it(@"should call .klarnaRegistrationFailed when web view failed to load",^{
    [[[kiaRegistrationDelegate should] receive] klarnaRegistrationFailed:kiaRegistrationController];
    
    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });
  
  it(@"should not call .klarnaRegistrationFailed when web view failed on NSURLErrorCancelled",^{
    [[[kiaRegistrationDelegate shouldNot] receive] klarnaRegistrationFailed:kiaRegistrationController];
    
    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });
  
  it(@"should register for Jockey events on load", ^{
    [KIAContext setApiKey:@"test_skadoo"];
    [[Jockey shouldEventually] receive:@selector(on:perform:) withArguments:@"userReady", any() ];
    [[Jockey shouldEventually] receive:@selector(on:perform:) withArguments:@"userError", any()];
    kiaRegistrationController.view;
  });
  
  context(@"Jockey .userReady", ^{
          afterEach(^{
            kiaRegistrationController.view;
            [Jockey send:@"userReady" withPayload:@{@"userToken":@"my_token"} toWebView:[kiaRegistrationController.view.subviews objectAtIndex:0]];
          });
    it(@"should...", ^ {
      [[KIAUtils shouldEventually] receive:@selector(saveUserToken:)];
    });
  });
  
});

SPEC_END
