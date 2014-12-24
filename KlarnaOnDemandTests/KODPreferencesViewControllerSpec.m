#import "KODPreferencesViewController.h"
#import "Jockey.h"
#import "KODContext.h"
#import "KODUrl.h"

SPEC_BEGIN(KODPreferencesViewControllerSpec)

describe(@"KODPreferencesViewControllerSpec", ^{
  __block id kiaPreferencesDelegate;
  __block KODPreferencesViewController *kiaPreferencesController;
  
  beforeEach(^{
    kiaPreferencesDelegate = [KWMock nullMockForProtocol:@protocol(KODPreferencesViewControllerDelegate)];
    kiaPreferencesController = [[KODPreferencesViewController alloc] initWithDelegate:kiaPreferencesDelegate andToken:@"my_token"];
    [KODContext stub:@selector(getApiKey) andReturn:@"test_skadoo"];
  });
  
  it(@"should call the delegate's .klarnaPreferencesFailed method when the web view fails to load", ^{
    [[[kiaPreferencesDelegate should] receive] klarnaPreferencesFailed:kiaPreferencesController];
    
    [kiaPreferencesController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:1234 userInfo:nil]];
  });
    
  it(@"does not call the delegate's .klarnaPreferencesFailed when the web view fails with NSURLErrorCancelled", ^{
    [[[kiaPreferencesDelegate shouldNot] receive] klarnaPreferencesFailed:kiaPreferencesController];
    
    [kiaPreferencesController webView:nil didFailLoadWithError:[NSError errorWithDomain:@"Domain" code:NSURLErrorCancelled userInfo:nil]];
  });
  
  it(@"should call the delegate's .klarnaPreferencesClosed when the dismiss button is pressed", ^{
    [[[kiaPreferencesDelegate should] receive] klarnaPreferencesClosed:kiaPreferencesController];
    
    [kiaPreferencesController dismissButtonPressed];
  });
  
});

SPEC_END
