#import "KODPreferencesViewController.h"
#import "Jockey.h"
#import "KODContext.h"
#import "KODUrl.h"

SPEC_BEGIN(KODPreferencesViewControllerSpec)

describe(@"KODPreferencesViewControllerSpec", ^{
  __block id kodPreferencesDelegate;
  __block KODPreferencesViewController *kodPreferencesController;
  
  beforeEach(^{
    kodPreferencesDelegate = [KWMock nullMockForProtocol:@protocol(KODPreferencesViewControllerDelegate)];
    kodPreferencesController = [[KODPreferencesViewController alloc] initWithDelegate:kodPreferencesDelegate andToken:@"my_token"];
    [KODContext stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });
  
  it(@"should call the delegate's .klarnaPreferencesFailed method when the web view fails to load", ^{
    [[[kodPreferencesDelegate should] receive] klarnaPreferencesFailed:kodPreferencesController];
    
    [kodPreferencesController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });
    
  it(@"does not call the delegate's .klarnaPreferencesFailed when the web view fails with NSURLErrorCancelled", ^{
    [[[kodPreferencesDelegate shouldNot] receive] klarnaPreferencesFailed:kodPreferencesController];
    
    [kodPreferencesController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });
  
  it(@"should call the delegate's .klarnaPreferencesClosed when the dismiss button is pressed", ^{
    [[[kodPreferencesDelegate should] receive] klarnaPreferencesClosed:kodPreferencesController];
    
    [kodPreferencesController dismissButtonPressed];
  });
  
});

SPEC_END
