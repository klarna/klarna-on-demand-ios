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
