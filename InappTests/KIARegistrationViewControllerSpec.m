#import "KIARegistrationViewController.h"
#import "Jockey.h"
#import "KIAContext.h"

SPEC_BEGIN(KIARegistrationViewControllerSpec)

describe(@"KIARegistrationViewControllerSpec", ^{
  __block id kiaRegistrationDelegate;
  __block KIARegistrationViewController *kiaRegistrationController;
  
  beforeEach(^{
    kiaRegistrationDelegate = [KWMock nullMockForProtocol:@protocol(KIARegistrationViewControllerDelegate)];
    kiaRegistrationController = [[KIARegistrationViewController alloc] initWithDelegate:kiaRegistrationDelegate];
    [KIAContext stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });
  
  it(@"should derive from KIAWebViewController", ^{
    [[kiaRegistrationController should] beKindOfClass:[KIAWebViewController class]];
  });
  
  it(@"should conform to UIWebViewDelegate protocol", ^ {
    [[[KIAWebViewController mock] should] conformToProtocol:@protocol(UIWebViewDelegate)];
  });
  
  it(@"should remove HUD View when web view failed to load",^{
    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
    
    [[kiaRegistrationController.HUDView.superview should] beNil];
  });
  
  it(@"should remove HUD View when dismiss button was pressed",^{
    [kiaRegistrationController dismissButtonPressed];
    
    [[kiaRegistrationController.HUDView should] beNil];
  });
  
  it(@"should initialize HUD View when on viewDidAppear",^{
    [kiaRegistrationController viewDidAppear:NO];
    
    [[kiaRegistrationController.HUDView shouldNot] beNil];
  });
  
  it(@"should initialize web view when on viewDidAppear",^{
    [kiaRegistrationController viewDidAppear:NO];
    
    [[kiaRegistrationController.webView shouldNot] beNil];
  });
  
  it(@"should register for Jockey events on viewDidAppear", ^{
    [KIAContext setApiKey:@"test_skadoo"];
    [[Jockey shouldEventually] receive:@selector(on:perform:) withArguments:@"userReady", any()];
    [[Jockey shouldEventually] receive:@selector(on:perform:) withArguments:@"userError", any()];
    
    [kiaRegistrationController viewDidAppear:NO];
  });
  
  it(@"should deregister for Jockey events on viewDidDisappear", ^{
    [KIAContext setApiKey:@"test_skadoo"];
    [[Jockey shouldEventually] receive:@selector(off:) withArguments:@"userReady"];
    [[Jockey shouldEventually] receive:@selector(off:) withArguments:@"userError"];
    
    [kiaRegistrationController viewDidDisappear:NO];
  });
  
  it(@"should call .klarnaRegistrationFailed when web view failed to load",^{
    [[[kiaRegistrationDelegate should] receive] klarnaRegistrationFailed:kiaRegistrationController];

    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });
  
  it(@"should not call .klarnaRegistrationFailed when web view failed on NSURLErrorCancelled",^{
    [[[kiaRegistrationDelegate shouldNot] receive] klarnaRegistrationFailed:kiaRegistrationController];

    [kiaRegistrationController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });

  it(@"should call .klarnaRegistrationCancelled when dismiss button was pressed",^{
      [[[kiaRegistrationDelegate should] receive] klarnaRegistrationCancelled:kiaRegistrationController];

      [kiaRegistrationController dismissButtonPressed];
    });
  
  it(@"call delegate on .handleUserReadyEvent when there is a token in payload", ^ {
      [[kiaRegistrationDelegate should] receive:@selector(klarnaRegistrationController:didFinishWithUserToken:) withArguments:kiaRegistrationController, [[KIAToken alloc] initWithToken:@"my_token"]];
      [kiaRegistrationController handleUserReadyEventWithPayload:@{@"userToken":@"my_token"}];
    });

  it(@"should call delegate on .handleUserErrorEvent", ^ {
      [[kiaRegistrationDelegate should] receive:@selector(klarnaRegistrationFailed:) withArguments:kiaRegistrationController];
      [kiaRegistrationController handleUserErrorEvent];
  });
});

SPEC_END
