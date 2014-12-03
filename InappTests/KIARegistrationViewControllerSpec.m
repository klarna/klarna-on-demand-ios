#import "KIARegistrationViewController.h"
#import "Jockey.h"
#import "KIAContext.h"

@interface KIARegistrationViewController (Test)
- (void) cancelButtonPressed;
- (void) handleUserReadyEventWithPayload: (NSDictionary *)payload;
- (void) handleUserErrorEvent;
@end

SPEC_BEGIN(KIARegistrationViewControllerSpec)

describe(@"KIARegistrationViewControllerSpec", ^{
  __block id kiaRegistrationDelegate;
  __block KIARegistrationViewController *kiaRegistrationController;
  
  beforeEach(^{
    kiaRegistrationDelegate = [KWMock nullMockForProtocol:@protocol(KIARegistrationViewControllerDelegate)];
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
    [[Jockey shouldEventually] receive:@selector(on:perform:) withArguments:@"userReady", any()];
    [[Jockey shouldEventually] receive:@selector(on:perform:) withArguments:@"userError", any()];
    
    [kiaRegistrationController view];
  });
  
  it(@"should deregister for Jockey events on disappear", ^{
    [KIAContext setApiKey:@"test_skadoo"];
    [[Jockey shouldEventually] receive:@selector(off:) withArguments:@"userReady"];
    [[Jockey shouldEventually] receive:@selector(off:) withArguments:@"userError"];
    
    [kiaRegistrationController viewDidDisappear:NO];
  });
  
  it(@"should save token and call delegate on .handleUserReadyEvent when there is a token in payload", ^ {
    [[kiaRegistrationDelegate should] receive:@selector(klarnaRegistrationController:didFinishWithUserToken:) withArguments:kiaRegistrationController, [[KIAToken alloc] initWithToken:@"my_token"]];
    [kiaRegistrationController handleUserReadyEventWithPayload:@{@"userToken":@"my_token"}];
  });
  
  it(@"should save token and call delegate on .handleUserErrorEvent", ^ {
    [[kiaRegistrationDelegate should] receive:@selector(klarnaRegistrationFailed:) withArguments:kiaRegistrationController];
    [kiaRegistrationController handleUserErrorEvent];
  });
  
});

SPEC_END
