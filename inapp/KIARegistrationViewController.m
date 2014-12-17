#import "KIARegistrationViewController.h"
#import "KIAUrl.h"
#import "Jockey.h"
#import "KIAContext.h"
#import "KIALocalization.h"

@interface KIARegistrationViewController ()

@property (weak, nonatomic) id<KIARegistrationViewControllerDelegate> delegate;

@end

@implementation KIARegistrationViewController

- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)delegate {
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
  return [KIALocalization localizedStringForKey:@"REGISTRATION_TITLE"];
}

- (NSString *)dismissButtonLabelKey {
  return @"REGISTRATION_DISMISS_BUTTON_TEXT";
}

- (NSURL *)url {
  return [KIAUrl registrationUrl];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [super webView:webView didFailLoadWithError:error];
  
  if (error.code != NSURLErrorCancelled && [_delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [_delegate klarnaRegistrationFailed:self];
  }
}

- (void)dismissButtonPressed {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationCancelled:)])
  {
    [_delegate klarnaRegistrationCancelled:self];
  }
}

- (void)handleUserReadyEventWithPayload:(NSDictionary *)payload {
  NSString *token = payload[@"userToken"];
  NSAssert(token, @"KIAToken failed to create.");
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationController:finishedWithUserToken:)])
  {
    KIAToken *kiaToken = [[KIAToken alloc] initWithToken: token];
    [_delegate klarnaRegistrationController:self finishedWithUserToken:kiaToken];
  }
}

- (void)handleUserErrorEvent {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [_delegate klarnaRegistrationFailed:self];
  }
}

@end