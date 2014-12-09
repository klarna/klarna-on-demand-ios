#Integration Guide
This guide includes all information necessary to receive payments from a user of your application through Klarna. We will see how to allow the user to register his device with Klarna, change payment preferences and perform purchases.

##Including the SDK in your project
This guide assumes you use [CocoaPods](http://cocoapods.org) to manage your project dependencies. If you do not, refer to our [official documentation](http://this_should_be_some_valid_link) for an alternative setup approach.

Open up your Podfile and add the following line:

    pod "InApp"

Then simply run `pod install` in your project directory and you will be good to go.

##The registration view
Users must go through a quick registration process in order to pay using Klarna. To make this process as simple as possible, the SDK provides a registration view that you should present to your users. Once the registration process is complete, you will receive a token that will allow you to receive payments from the user.

###Showing the view
For the sake of this example, we will assume we have a button that launches the registration view (this is not a very good way to decide when to show the view, but more on that [later](#how_to_show_registration)).

First off, import the registration view's header file into your view controller:

```objective-c
#import "KIARegistrationViewController.h"
```


<a name="how_to_show_registration"></a>
###How will I know if the user is registered with Klarna?
I am really not sure this section should exist. BWHAHA.

A very important question, as you should not intrude on a registered user's experience by showing him the registration view unnecessarily. It is ultimately up to your application