#import <UIKit/UIKit.h>
#import "KIARegistrationViewController.h"
#import "KIAPreferencesViewController.h"

@interface MainViewController : UIViewController<KIARegistrationViewControllerDelegate, KIAPreferencesViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *mainButton;

@property (weak, nonatomic) IBOutlet UILabel *registerLabel;

@property (weak, nonatomic) IBOutlet UIView *QRView;

@end

