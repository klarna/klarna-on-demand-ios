#import <UIKit/UIKit.h>

@interface KIAWebViewController : UIViewController <UIWebViewDelegate>

@property(strong, nonatomic) UIWebView *webView;
@property(strong, nonatomic) UIView *HUDView;

@end
