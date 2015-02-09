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
  NSMutableDictionary *mutablePayload = [payload mutableCopy];
  NSString *token = [self popFromDictionary:mutablePayload withKey:@"userToken"];
  NSAssert(token, @"KODToken failed to create.");
  if ([self.delegate respondsToSelector:@selector(klarnaRegistrationController:finishedWithResult:)]) {
    NSString *phoneNumber = [self popFromDictionary:mutablePayload withKey:@"phoneNumber"];
    KODRegistrationResult *kodRegistrationResult = [[KODRegistrationResult alloc]
                                                    initWithToken:token
                                                    andPhoneNumber:phoneNumber
                                                    andUserDetails:mutablePayload];
    
    [self.delegate klarnaRegistrationController:self finishedWithResult:kodRegistrationResult];
  }
}

- (id)popFromDictionary:(NSMutableDictionary *)dictionary withKey:(NSString *)key {
  NSString *value = dictionary[key];
  [dictionary removeObjectForKey:key];
  return value;
}

- (void)handleUserErrorEvent {
  if ([self.delegate respondsToSelector:@selector(klarnaRegistrationFailed:)]) {
    [self.delegate klarnaRegistrationFailed:self];
  }
}

@end