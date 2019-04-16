#import "KODPreferencesViewController.h"
#import "Jockey.h"
#import "KODContext.h"
#import "KODUrl.h"

SPEC_BEGIN(KODPreferencesViewControllerSpec)

describe(@"KODPreferencesViewControllerSpec", ^{
  __block id kodPreferencesDelegate;
  __block KODPreferencesViewController *kodPreferencesController;
  WKWebView *webView = [WKWebView mock];
  
  beforeEach(^{
    kodPreferencesDelegate = [KWMock nullMockForProtocol:@protocol(KODPreferencesViewControllerDelegate)];
    kodPreferencesController = [[KODPreferencesViewController alloc] initWithDelegate:kodPreferencesDelegate andToken:@"my_token"];
    [KODContext stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });

  it(@"does not call the delegate's .klarnaPreferencesFailed when the web view fails with NSURLErrorCancelled", ^{
      NSError *error = [[NSError alloc] initWithDomain:@"Domain" code:1234 userInfo:nil];
      
      [[kodPreferencesDelegate shouldNot] receive:@selector(klarnaPreferencesFailed:withError:) withArguments:kodPreferencesController, error];
    
    [kodPreferencesController webView:webView didFailNavigation:nil withError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });

  it(@"should call the delegate's didFailNavigation method when the web view fails to provisionally navigate", ^{
    [[kodPreferencesController should] receive:@selector(webView:didFailNavigation:withError:)];

    [kodPreferencesController webView:webView didFailProvisionalNavigation:nil withError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });

  it(@"should call the delegate's .klarnaPreferencesClosed when the dismiss button is pressed", ^{
    [[kodPreferencesDelegate should] receive:@selector(klarnaPreferencesClosed:) withArguments:kodPreferencesController];
    
    [kodPreferencesController dismissButtonPressed];
  });

  it(@"does not call the delegate's .klarnaPrefencesFailed when the web view fails with NSURLErrorCancelled", ^{
      NSError *error = [[NSError alloc] initWithDomain:@"Domain" code:1234 userInfo:nil];
      
      [[kodPreferencesDelegate shouldNot] receive:@selector(klarnaPreferencesFailed:withError:) withArguments:kodPreferencesController, error];

    [kodPreferencesController webView:webView didFailNavigation:nil withError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });
});

SPEC_END
