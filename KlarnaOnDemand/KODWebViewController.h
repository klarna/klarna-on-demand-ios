#import <UIKit/UIKit.h>

@interface KODWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIView *HUDView;

@end
