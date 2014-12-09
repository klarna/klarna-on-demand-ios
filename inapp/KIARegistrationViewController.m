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

-(id)init {
  NSAssert(NO, @"Initialize with -initWithDelegate");
  return nil;
}

- (NSString *)title {
  return [KIALocalization localizedStringForKey:@"REGISTRATION_TITLE"];
}

- (NSURL *)Url {
  return [KIAUrl registrationUrl];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [super webView:webView didFailLoadWithError:error];
  
  if ([error code] != NSURLErrorCancelled && [_delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [_delegate klarnaRegistrationFailed:self];
  }
}

- (void)cancelButtonPressed {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationCancelled:)])
  {
    [_delegate klarnaRegistrationCancelled:self];
  }
}

- (void)handleUserReadyEventWithPayload: (NSDictionary *)payload {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationController:didFinishWithUserToken:)])
  {
    [_delegate klarnaRegistrationController:self didFinishWithUserToken:[[KIAToken alloc] initWithToken: payload[@"userToken"]]];
  }
}

- (void)handleUserErrorEvent {
  if ([_delegate respondsToSelector:@selector(klarnaRegistrationFailed:)])
  {
    [_delegate klarnaRegistrationFailed:self];
  }
}

@end