#import "KODRegistrationViewController.h"
#import "KODUrl.h"
#import "Jockey.h"
#import "KODContext.h"
#import "KODLocalization.h"

@interface KODRegistrationViewController ()

@property (weak, nonatomic) id<KODRegistrationViewControllerDelegate> delegate;
@property (strong, nonatomic) KODRegistrationSettings *registrationSettings;

@end

@implementation KODRegistrationViewController

- (id)initWithDelegate:(id<KODRegistrationViewControllerDelegate>)delegate andRegistrationSettings: (KODRegistrationSettings *) registrationSettings {
  self = [super init];
  if (self) {
    self.delegate = delegate;
    self.registrationSettings = registrationSettings;
  }
  return self;
}

- (id)initWithDelegate:(id<KODRegistrationViewControllerDelegate>)delegate {
  return [self initWithDelegate:delegate andRegistrationSettings:nil];
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
  return [KODUrl registrationUrlWithSettings: _registrationSettings];
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

#pragma mark WKNavigationDelegate methods

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
  [super webView:webView didFailNavigation:navigation withError:error];

  if (error.code != NSURLErrorCancelled && [self.delegate respondsToSelector:@selector(klarnaRegistrationFailed:)]) {
    [self.delegate klarnaRegistrationFailed:self];
  }
}

@end