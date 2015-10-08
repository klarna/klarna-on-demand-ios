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
    self.delegate = delegate;
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
  
  if (error.code != NSURLErrorCancelled && [self.delegate respondsToSelector:@selector(klarnaRegistrationFailed:)]) {
    [self.delegate klarnaRegistrationFailed:self];
  }
}

- (void)dismissButtonPressed {
  if ([self.delegate respondsToSelector:@selector(klarnaRegistrationCancelled:)]) {
    [self.delegate klarnaRegistrationCancelled:self];
  }
}

- (void)handleUserReadyEventWithPayload:(NSDictionary *)payload {
  NSString *token = payload[@"userToken"];
  if ([self.delegate respondsToSelector:@selector(klarnaRegistrationController:finishedWithResult:)]) {
        KODRegistrationResult *kodRegistrationResult = [[KODRegistrationResult alloc] initWithToken:token];
    [self.delegate klarnaRegistrationController:self finishedWithResult:kodRegistrationResult];
  }
}

- (void)handleUserErrorEvent {
  if ([self.delegate respondsToSelector:@selector(klarnaRegistrationFailed:)]) {
    [self.delegate klarnaRegistrationFailed:self];
  }
}

@end