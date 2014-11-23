//
//  KIAViewController.h
//  InApp
//
//  Created by Guy Rozen on 11/17/2014.
//  Copyright (c) 2014 Guy Rozen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIARegistrationViewController.h"

@interface KIAViewController : UIViewController <KIARegistrationViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
