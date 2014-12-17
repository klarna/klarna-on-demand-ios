#Integration Guide
This guide includes all information necessary to receive payments from a user of your application through Klarna. In this guide, you will see how to allow the user to register his device with Klarna, change payment preferences and perform purchases.

##Including the SDK in your project
This guide assumes you use [CocoaPods](http://cocoapods.org) to manage your project dependencies. If you do not, refer to our [official documentation](http://this_should_be_some_valid_link) for an alternative setup approach.

Open up your Podfile and add the following line:

    pod "InApp"

Then simply run `pod install` in your project directory and you will be good to go.

##Supplying your API key
In order to use the SDK, you will need an API key to identify yourself. You can get one from our [developer site](http://developers.klarna.com/).

We recommend setting your API key in your AppDelegate in the manner shown below:

```objective-c
#import "AppDelegate.h"
#import "KIAContext.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Set Klarna's API key. This is an actual test key that you can use to try things out,
  // though it would be best to use your personalized test key.
  [KIAContext setApiKey:@"test_29f612e8-1576-423f-80a8-679f354e4c89"];
  return YES;
}
@end
```

##The registration view
Users must go through a quick registration process in order to pay using Klarna. To make this process as simple as possible, the SDK provides a registration view that you should present to your users. Once the registration process is complete, you will receive a token that will allow you to receive payments from the user.

**Note:** It is important to point out that the registration view will not function properly without network access.

###Showing the view
For the sake of this example, we will assume we have a button that launches the registration view (we will cover a better way to handle this [later](#when_to_show_registration)).

First off, import the registration view's header file into your view controller:

```objective-c
#import "KIARegistrationViewController.h"
```

Then, assuming the button's touch handler is called `onRegisterPressed`, set it up like this:

```objective-c
- (IBAction)onRegisterPressed:(id)sender {
  // Create a new Klarna registration view controller, initialized with the containing controller as event-handler
  KIARegistrationViewController *registrationViewController = [[KIARegistrationViewController alloc] initWithDelegate:self];

  // Create a navigation controller with the registration view controller as its root view controller
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:registrationViewController];

  // Show navigation controller (as a modal)
  [self presentViewController:navigationController
                     animated:YES
                   completion:nil];
}
```

There are a couple of things that are worth pointing out in the code above:
- To properly initialize the registration view, you need to supply it with a delegate that it will use to notify you of various important events. We will go over these events later when we examine the [KIARegistrationViewControllerDelegate](#kia_registration_view_controller_delegate) protocol. We recommend having the view controller that hosts the registration view conform to said protocol.
- We display the registration view by making it part of a navigation view controller. This is the recommended way to display the registration view, and will give users the option to back out of the registration process.

This is really all there is to displaying the registration view.

###Interacting with the view
Displaying the view is great, but will only get you so far. It is important to know how our users interact with the view and to that end the view dispatches events to a delegate supplied during its initialization.

<a name="kia_registration_view_controller_delegate"></a>
####The KIARegistrationViewControllerDelegate protocol
The registration view expects its delegate to comform to this protocol, which exposes three different types of callbacks:

1. Registration complete - the user successfully completed the registration process, and has been assigned a token that you can use to place orders on the user's behalf.
2. Registration cancelled - the user chose to back out of the registration process.
3. Registration failed - an error of some sort has prevented the user from successfully going through the registration process.

Building upon the code sample from the previous section, consider the following methods which make a view controller conform to the KIARegistrationViewControllerDelegate protocol. The methods correspond to the types of callbacks we have just listed:

```objective-c
- (void)klarnaRegistrationController:(KIARegistrationViewController *)controller didFinishWithUserToken:(KIAToken *)userToken {
  // Dismiss the registration view and store the user's token
  [self dismissViewControllerAnimated:YES completion:nil];
  [self saveUserToken:userToken.token]; // this is for illustrative purposes, we do not supply this method
}

- (void)klarnaRegistrationCancelled:(KIARegistrationViewController *)controller {
  // Dismiss the registration view
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)klarnaRegistrationFailed:(KIARegistrationViewController *)controller {
  // Dismiss Klarna registration view and notify the user of the error
  [self dismissViewControllerAnimated:YES completion:nil];
  [self notifyRegistrationFailed]; // Again, this is just an illustration
}

```

As you can see, your first order of business will usually be to dismiss the registration view upon any of the events occurring. Then, depending on the event, you will want to take further action such as storing the user token or displaying an error message.

<a name="when_to_show_registration"></a>
###When should you show the registration view?
While we've seen how to utilize the registration view, we never talked about **when** you should display it. While it is ultimately up to you to decide, we have a fairly straightforward recommendation - you should only display the registration view when you do not have a user token stored. Assuming your user has gone through the registration process successfully and received a token there is no need to have the user register again, as tokens do not expire (though they can be revoked).

##The preferences view
After having registered to pay using Klarna, users may wish to alter their payment settings (for example, users may wish to switch from using a credit card to monthly invoice payments). As was the case with registration, the SDK provides a view for this purpose. Using the user token acquired during the registration process, you will be able to present the preferences view for your users.

**Note:** It is important to point out that the preferences view will not function properly without network access.

###Showing the view
It is good practice to allow users to access the preferences view on demand. Let's see how to set up a button that launches the preferences view.

First, import the preferences view's header file into your view controller:

```objective-c
#import "KIAPreferencesViewController.h"
```

Then, assuming the button's touch handler is called `onPreferencesPressed`, set it up in the following manner:

```objective-c
- (IBAction)onPreferencesPressed:(id)sender {
  // Create a new Klarna preferences view-controller, initialized with MainViewController as the event-handler, and the user token that was saved when the user completed the registration process.
  KIAPreferencesViewController *preferencesViewController = [[KIAPreferencesViewController alloc] initWithDelegate:self andToken:[self getUserToken]];

  // Create navigation controller with Klarna preferences view-controller as the root view controller.
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:preferencesViewController];

  // Show navigation controller (in a modal presentation).
  [self presentViewController:navigationController
                     animated:YES
                   completion:nil];
}
```

There are a couple of things that are worth pointing out in the code above:
- To properly initialize the registration view, you need to supply it with a delegate that it will use to notify you of various important events. We will go over these events later when we examine the [KIARegistrationViewControllerDelegate](#kia_registration_view_controller_delegate) protocol. We recommend having the view controller that hosts the registration view conform to said protocol.
- We display the registration view by making it part of a navigation view controller. This is the recommended way to display the registration view, and will give users the option to back out of the registration process.

This is really all there is to displaying the registration view.

###Interacting with the view
Displaying the view is great, but will only get you so far. It is important to know how our users interact with the view and to that end the view dispatches events to a delegate supplied during its initialization.

<a name="kia_registration_view_controller_delegate"></a>
####The KIARegistrationViewControllerDelegate protocol
The registration view expects its delegate to comform to this protocol, which exposes three different types of callbacks:

1. Registration complete - the user successfully completed the registration process, and has been assigned a token that you can use to place orders on the user's behalf.
2. Registration cancelled - the user chose to back out of the registration process.
3. Registration failed - an error of some sort has prevented the user from successfully going through the registration process.

Building upon the code sample from the previous section, consider the following methods which make a view controller conform to the KIARegistrationViewControllerDelegate protocol. The methods correspond to the types of callbacks we have just listed:

```objective-c
- (void)klarnaRegistrationController:(KIARegistrationViewController *)controller finishedWithUserToken:(KIAToken *)userToken {
  // Dismiss the registration view and store the user's token
  [self dismissViewControllerAnimated:YES completion:nil];
  [self saveUserToken:userToken.token]; // this is for illustrative purposes, we do not supply this method
}

- (void)klarnaRegistrationCancelled:(KIARegistrationViewController *)controller {
  // Dismiss the registration view
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)klarnaRegistrationFailed:(KIARegistrationViewController *)controller {
  // Dismiss Klarna registration view and notify the user of the error
  [self dismissViewControllerAnimated:YES completion:nil];
  [self notifyRegistrationFailed]; // Again, this is just an illustration
}

```

As you can see, your first order of business will usually be to dismiss the registration view upon any of the events occurring. Then, depending on the event, you will want to take further action such as storing the user token or displaying an error message.

<a name="when_to_show_registration"></a>
###When should you show the registration view?
While we've seen how to utilize the registration view, we never talked about **when** you should display it. While it is ultimately up to you to decide, we have a fairly straightforward recommendation - you should only display the registration view when you do not have a user token stored. Assuming your user has gone through the registration process successfully and received a token there is no need to have the user register again, as tokens do not expire (though they can be revoked).
