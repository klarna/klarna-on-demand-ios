#import "KODRegistrationViewController.h"
#import "Jockey.h"
#import "KODContext.h"

SPEC_BEGIN(KODRegistrationViewControllerSpec)

describe(@"KODRegistrationViewControllerSpec", ^{
  __block id kodRegistrationDelegate;
  __block KODRegistrationViewController *kodRegistrationController;
  WKWebView *webView = [WKWebView mock];
  
  beforeEach(^{
    kodRegistrationDelegate = [KWMock nullMockForProtocol:@protocol(KODRegistrationViewControllerDelegate)];
    kodRegistrationController = [[KODRegistrationViewController alloc] initWithDelegate:kodRegistrationDelegate];
    [KODContext stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });
  
  it(@"should call delegate's .klarnaRegistrationController:finishedWithResult on .handleUserReadyEvent when a token was received", ^{
    KODRegistrationResult *expectedRegistrationResult = [[KODRegistrationResult alloc] initWithToken:@"my_token"];
    
    [[kodRegistrationDelegate should] receive:@selector(klarnaRegistrationController:finishedWithResult:) withArguments:kodRegistrationController, expectedRegistrationResult];
    
    [kodRegistrationController handleUserReadyEventWithPayload:@{@"userToken":@"my_token"}];
  });

  it(@"should call the delegate's .klarnaRegistrationFailed method when the web view fails to navigate", ^{
    [[kodRegistrationDelegate should] receive:@selector(klarnaRegistrationFailed:) withArguments:kodRegistrationController];

    [kodRegistrationController webView:webView didFailNavigation:nil withError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });

  it(@"should call the delegate's didFailNavigation method when the web view fails to provisionally navigate", ^{
    [[kodRegistrationController should] receive:@selector(webView:didFailNavigation:withError:)];
    
    [kodRegistrationController webView:webView didFailProvisionalNavigation:nil withError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });

  it(@"does not call the delegate's .klarnaRegistrationFailed when the web view fails with NSURLErrorCancelled", ^{
    [[kodRegistrationDelegate shouldNot] receive:@selector(klarnaRegistrationFailed:) withArguments:kodRegistrationController];

    [kodRegistrationController webView:webView didFailNavigation:nil withError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });

  it(@"should call the delegate's .klarnaRegistrationCancelled when the dismiss button is pressed", ^{
    [[kodRegistrationDelegate should] receive:@selector(klarnaRegistrationCancelled:) withArguments:kodRegistrationController];

    [kodRegistrationController dismissButtonPressed];
  });
});

SPEC_END
