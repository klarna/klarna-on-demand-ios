#import <UIKit/UIKit.h>
#import "KODRegistrationViewController.h"
#import "KODPreferencesViewController.h"

@interface MainViewController : UIViewController<KODRegistrationViewControllerDelegate, KODPreferencesViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@property (weak, nonatomic) IBOutlet UILabel *registerLabel;

@property (weak, nonatomic) IBOutlet UIButton *changePaymentButton;

@property (weak, nonatomic) IBOutlet UIView *QRView;

@end

