# InApp

[![CI Status](https://api.travis-ci.org/yuval-netanel/inapp-ios.svg?style=flat)](https://travis-ci.org/yuval-netanel/inapp-ios)
[![Version](https://img.shields.io/cocoapods/v/InApp.svg?style=flat)](http://cocoadocs.org/docsets/InApp)
[![License](https://img.shields.io/cocoapods/l/InApp.svg?style=flat)](http://cocoadocs.org/docsets/InApp)
[![Platform](https://img.shields.io/cocoapods/p/InApp.svg?style=flat)](http://cocoadocs.org/docsets/InApp)

This project contains Klarna's In-App purchase SDK for iOS, as well as a sample application utilizing the SDK.

![It's Klarna in your App](https://raw.githubusercontent.com/yuval-netanel/inapp-ios/IACO-527-github-documentation/screenshot.png)

While not necessary, the simplest way to get going with both the sample application and the SDK is to use [CocoaPods](http://cocoapods.org) and so all the following instructions will focus on that approach. For an alternative approach, see the [official documentation](http://this_should_be_some_valid_link).

## Using the SDK
Have a look at the [integration guide](doc/integration.md) for full details in how to use our API in your application.

## Running the sample application
Assuming you've cloned the repository, simply cd into the repo, open *Inapp.xcworkspace* and run the *InappExample* project.

## Contributing
You'd like to help us out? That's great! Here's what you need to do in order to contribute.

### Prerequisites
You'll need to install [CocoaPods](http://cocoapods.org) in order to properly work on the project. Assuming you have [Ruby](https://www.ruby-lang.org/en/downloads/) installed, all you need to do is type this into your terminal:

    gem install cocoapods

### Setup

1. Fork the project and clone your repository
2. In the project folder, run `pod install`
3. Open Inapp.xcworkspace and code away

### Tests
A pull request must include tests for the proposed fixes/functionality. We use [Kiwi](https://github.com/kiwi-bdd/Kiwi) to write our tests and you can find the tests themselves under the *Inapp* project in the *InappTets* folder.


## Author

Klarna

## License

InApp is available under the Apache 2.0 license. See the LICENSE file for more info.