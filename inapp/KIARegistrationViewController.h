#import <UIKit/UIKit.h>

@protocol KIARegistrationViewControllerDelegate;


@interface KIARegistrationViewController : UIViewController <UIWebViewDelegate>

- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)delegate;
@end



@protocol KIARegistrationViewControllerDelegate <NSObject>

@end
