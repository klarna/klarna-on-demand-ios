Note: Please mark completed/checked bullets with Use ~~ ~~tildes around the words~~. ~~ (GitHub MarkDown)

##SDK

###`KIAContext`

 * ~~`validateApiKey` could assert for APIKey length - instead of checking for the current 2 conditions.~~
 * I would consider generating a private singleton, so it could handle possible (in the future) additional properties instead of using static instances.

Additional notes:
Use Apple Doc and generate, making it available via Dash

### `KIARegistrationViewController`

 * ~~Is there any special reason the protocol methods is declared after the class?~~
 * ~~We could add a method that presents the `KIARegistrationViewController` (or KIARegistrationViewController could be/return a `UINavigationController`)~~
 * ~~Delegate methods are required, right? If so, they should be declared as required.~~
 * ~~We should create an assert method to make sure developers don't simply call:~~
 ```
 KIARegistrationViewController *klarnaViewController = [[KIARegistrationViewController alloc] init];
 ``` 
* ~~Can we pass an instance of `NSError` in the `klarnaRegistrationFailed` delegate method?~~ - for simplicity, we have decided that we will not report the error cause.
* ~~Would be better if `id<KIARegistrationViewControllerDelegate>` was declared as a property.~~
* ~~`AddSpinner` method: (1) HardCoded is not ideal; (2) I would call it HUD rather than spinner; (3) SVProgressHUD is an excellent open source component for that purposes, I would consider using it (specially if there would be more use cases for a loader.)~~ - SVProgressHUD will be implemented. what about MBProgressHUD?
* ~~Line 82: `[error code]` - I prefer (and there is a strong consensus in the community) using the dot notation for properties, and square bracket for methods.~~
* Line 112: (1) I would prefer to define the token in a separate line. (2) Is there any validation to make sure that the `NSDictionary` received is not `nil`, and that the parameter `userToken` is not `nil` as well?
* ~~Line 124: `viewDidDisappear:` is not calling `super...`. Also, it's recommended that view related methods are subclassed together, below `init` methods.~~

###`KIAURL`
* In this case, it's much preferred to use a category instead of a subclass of `NSObject`.
* All the strings that are constants should be declared with constants and not `#define`.

###`KIAToken`
* Why the property `token` is `weak`?!
* A class method could be easier for this purpose, right? Moreover, why can't it handle opening the `NSDictionary`? Something like:
```
```
KIAToken *token = [KIAToken tokenFromDictionary:payload];
```

##App example
* ~~In the app delegate, I would explain the `[KIAContext setApiKey:]` line~~
* ~~The test api key will be available for every developer to test? If not, it should be removed, no?~~

## General notes:

* Style: I like following the [Style Guide developed by the iOS team at The New York Times](https://github.com/NYTimes/objective-c-style-guide). I can show you guys with more details - the style guide is very long - but the basics that I noticed that don't match are: indentation, private properties as ivars, method signatures and spacing, constants preferred over in-line string literals or numbers or #defines.
* [NSAssert Vs. NSCAssert](http://nshipster.com/nsassertionhandler/): NSAssert should only be used in an Objective-C context (i.e. method implementations), whereas NSCAssert should only be used in a C context (i.e. functions).
* Usage of `# Pragma - Mark` is extremely useful
* Would be better  if`Jockey` was available through CocoaPods. Check the already open issue here: https://github.com/tcoulter/jockeyjs/issues/8
* Method names should start with lowercase characters
* Blank line before return or if statements
* Classes prefix: KIA Vs. KLA, KLN
