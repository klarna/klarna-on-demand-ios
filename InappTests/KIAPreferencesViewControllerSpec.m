#import "KIAPreferencesViewController.h"
#import "Jockey.h"
#import "KIAContext.h"
#import "KIAUrl.h"

SPEC_BEGIN(KIAPreferencesViewControllerSpec)

describe(@"KIAPreferencesViewControllerSpec", ^{
  __block id kiaPreferencesDelegate;
  __block KIAPreferencesViewController *kiaPreferencesController;
  beforeEach(^{
    kiaPreferencesDelegate = [KWMock nullMockForProtocol:@protocol(KIAPreferencesViewControllerDelegate)];
    kiaPreferencesController = [[KIAPreferencesViewController alloc] initWithDelegate:kiaPreferencesDelegate andToken:@"my_token"];
    [KIAContext stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });
  
  it(@"should derive from KIAWebViewController", ^{
    [[kiaPreferencesController should] beKindOfClass:[KIAWebViewController class]];
  });
  
  it(@"should conform to UIWebViewDelegate protocol", ^ {
    [[[KIAWebViewController mock] should] conformToProtocol:@protocol(UIWebViewDelegate)];
  });
  
  it(@"should remove HUD View when web view failed to load",^{
    [kiaPreferencesController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
    
    [[kiaPreferencesController.HUDView.superview should] beNil];
  });
  
  it(@"should remove HUD View when dismiss button was pressed",^{
    [kiaPreferencesController dismissButtonPressed];
    
    [[kiaPreferencesController.HUDView should] beNil];
  });
  
  it(@"should initialize HUD View when on viewDidAppear",^{
    [kiaPreferencesController viewDidAppear:NO];
    
    [[kiaPreferencesController.HUDView shouldNot] beNil];
  });
  
  it(@"should initialize web view when on viewDidAppear",^{
    [kiaPreferencesController viewDidAppear:NO];
    
    [[kiaPreferencesController.webView shouldNot] beNil];
  });
  
  it(@"should register for Jockey events on viewDidAppear", ^{
    [KIAContext setApiKey:@"test_skadoo"];
    [[Jockey shouldEventually] receive:@selector(on:perform:) withArguments:@"userReady", any()];
    [[Jockey shouldEventually] receive:@selector(on:perform:) withArguments:@"userError", any()];
    
    [kiaPreferencesController viewDidAppear:NO];
  });
  
  it(@"should deregister for Jockey events on viewDidDisappear", ^{
    [KIAContext setApiKey:@"test_skadoo"];
    [[Jockey shouldEventually] receive:@selector(off:) withArguments:@"userReady"];
    [[Jockey shouldEventually] receive:@selector(off:) withArguments:@"userError"];
    
    [kiaPreferencesController viewDidDisappear:NO];
  });
  
  it(@"should call .klarnaPreferencesFailed when web view failed to load",^{
    [[[kiaPreferencesDelegate should] receive] klarnaPreferencesFailed:kiaPreferencesController];
    
    [kiaPreferencesController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });
  
  it(@"should not call .klarnaPreferencesFailed when web view failed on NSURLErrorCancelled",^{
    [[[kiaPreferencesDelegate shouldNot] receive] klarnaPreferencesFailed:kiaPreferencesController];
    
    [kiaPreferencesController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });
  
  it(@"should call .klarnaPreferencesCancelled when dismiss button was pressed",^{
    [[[kiaPreferencesDelegate should] receive] klarnaPreferencesCancelled:kiaPreferencesController];
    
    [kiaPreferencesController dismissButtonPressed];
  });
  
  it(@"call delegate on .handleUserReadyEvent when there is a token in payload", ^{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[KIAUrl preferencesUrlWithToken:@"my_token"]
                     cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:60.0f];
    [kiaPreferencesController viewDidAppear:NO];
    [[kiaPreferencesController.webView should] receive:@selector(loadRequest:) withArguments:urlRequest];
    [kiaPreferencesController handleUserReadyEventWithPayload:@{}];
  });
  
  it(@"should call delegate on .handleUserErrorEvent", ^ {
    [[kiaPreferencesDelegate should] receive:@selector(klarnaPreferencesFailed:) withArguments:kiaPreferencesController];
    [kiaPreferencesController handleUserErrorEvent];
  });
});

SPEC_END
