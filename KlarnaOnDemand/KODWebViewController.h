#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface KODWebViewController : UIViewController <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIView *HUDView;

@end
