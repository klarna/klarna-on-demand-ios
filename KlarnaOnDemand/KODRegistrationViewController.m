#import "KODRegistrationViewController.h"
#import "KODUrl.h"
#import "Jockey.h"
#import "KODContext.h"
#import "KODLocalization.h"

@interface KODRegistrationViewController ()

@property (weak, nonatomic) id<KODRegistrationViewControllerDelegate> delegate;

@end

@implementation KODRegistrationViewController

- (id)initWithDelegate:(id<KODRegistrationViewControllerDelegate>)delegate {
  self = [super init];
  if (self) {
    _delegate = delegate;
  }
  return self;
}

- (id)init {
  NSAssert(NO, @"Initialize with -initWithDelegate");
  return nil;
}

- (NSString *)title {
  return [KODLocalization localizedStringForKey:@"REGISTRATION_TITLE"];
}

- (NSString *)dismissButtonLabelKey {
  return @"REGISTRATION_DISMISS_BUTTON_TEXT";
}

- (NSURL *)url {
  return [KODUrl registrationUrl];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [super webView:webView didFailLoadWithError:error];
  
  if (error.code != NSURLErrorCancelled && [_delegate respondsToSelector:@selector(klarnaRegistrationFailed:)]) {
    [_delegate klarnaRegistrationFailed:self];
  }
}

- (void)dismissButtonPressed {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationCancelled:)]) {
    [_delegate klarnaRegistrationCancelled:self];
  }
}

- (void)handleUserReadyEventWithPayload:(NSDictionary *)payload {
  NSString *token = payload[@"userToken"];
  NSAssert(token, @"KODToken failed to create.");
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationController:finishedWithResult:)]) {
    KODRegistrationResult *kodRegistrationResult = [[KODRegistrationResult alloc] initWithToken: token];
    [_delegate klarnaRegistrationController:self finishedWithResult:kodRegistrationResult];
  }
}

- (void)handleUserErrorEvent {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationFailed:)]) {
    [_delegate klarnaRegistrationFailed:self];
  }
}

@end