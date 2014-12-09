#import <UIKit/UIKit.h>
#import "KIARegistrationViewController.h"

@interface MainViewController : UIViewController<KIARegistrationViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@property (weak, nonatomic) IBOutlet UIButton *preferencesButton;

@end

