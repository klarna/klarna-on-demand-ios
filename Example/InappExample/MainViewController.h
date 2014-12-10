#import <UIKit/UIKit.h>
#import "KIARegistrationViewController.h"
#import "KIAPreferencesViewController.h"

@interface MainViewController : UIViewController<KIARegistrationViewControllerDelegate,KIAPreferencesViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@property (weak, nonatomic) IBOutlet UIButton *preferencesButton;

@end

