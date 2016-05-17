#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface KODWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIView *HUDView;

@end
