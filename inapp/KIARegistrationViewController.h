#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol KIARegistrationViewControllerDelegate;


@interface KIARegistrationViewController : UIViewController <UIWebViewDelegate>

- (id)initWithDelegate:(id<KIARegistrationViewControllerDelegate>)delegate;


@end



@protocol KIARegistrationViewControllerDelegate <NSObject>

typedef enum KIARegistrationError : NSInteger KIARegistrationError;

-(void) klarnaRegistrationFailed:(KIARegistrationViewController *) controller;

@end
