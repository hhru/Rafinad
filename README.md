# Rafinad
[![Build Status](https://github.com/hhru/Rafinad/actions/workflows/swift.yml/badge.svg)](https://github.com/hhru/Rafinad/actions)
[![Cocoapods](https://img.shields.io/cocoapods/v/Rafinad)](http://cocoapods.org/pods/Rafinad)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen)](https://github.com/Carthage/Carthage)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Platforms](https://img.shields.io/cocoapods/p/Rafinad)](https://developer.apple.com/discover/)
[![Xcode](https://img.shields.io/badge/Xcode-16-blue)](https://developer.apple.com/xcode)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange)](https://swift.org)
[![License](https://img.shields.io/github/license/hhru/Rafinad)](https://opensource.org/licenses/MIT)

Rafinad is a DSL for UI testing of iOS and tvOS apps, featuring a simplified, chainable, and compile-time-safe syntax.


## Contents
- [Requirements](#requirements)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [Carthage](#carthage)
    - [CocoaPods](#cocoapods)
- [Usage](#usage)
    - [Quick Start](#quick-start)
    - [Example App](#example-app)
- [Communication](#communication)
- [License](#license)


## Requirements
- iOS 15.0+ / tvOS 15.0+
- Xcode 16.0+
- Swift 5.9+


## Installation

### Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code.
It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate Rafinad into your Xcode project using Swift Package Manager,
add it to the `dependencies` value of your `Package.swift` or the Package list in Xcode:

``` swift
.package(url: "https://github.com/hhru/Rafinad.git", from: "1.0.0")
```

Then specify the dependencies for the corresponding targets of your project:
- `RafinadTesting` for the UI testing target
- `Rafinad` for both the app target and the UI testing target


### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. You can install Carthage with Homebrew using the following command:
``` bash
$ brew update
$ brew install carthage
```

To integrate Rafinad into your Xcode project using Carthage, specify it in your `Cartfile`:
``` ogdl
github "hhru/Rafinad" ~> 1.0.0
```

Then run `carthage update  --use-xcframeworks` to build the frameworks.

Finally, drag the built `.xcframework` bundles from the `Carthage/Build` folder into the "Frameworks and Libraries" section of your project's corresponding targets:
- `RafinadTesting.xcframework` for the UI testing target
- `Rafinad.xcframework` for both the app target and the UI testing target


### CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

``` bash
$ gem install cocoapods
```

To integrate Rafinad into your Xcode project using [CocoaPods](http://cocoapods.org), specify its subspecs in your `Podfile`:

``` ruby
platform :ios, '15.0'
use_frameworks!

target '<Your App Target Name>' do
    pod 'Rafinad/Accessibility', '~> 1.0.0'
end

target '<Your UI Testing Target Name>' do
    pod 'Rafinad', '~> 1.0.0'
end
```

Finally, run the following command:

``` bash
$ pod install
```


## Usage
[Documentation](http://tech.hh.ru/Rafinad/documentation/rafinad)

### Quick Start
Let's walk through a simple example screen, that displays user information.
For simplicity, we'll only show the user's name and position.
To use Rafinad on this screen in your tests, the first step is to create an accessibility scheme
by subclassing the base `ScreenAccessibility` class:

``` swift
// Accessibility scheme for the user screen
class UserAccessibility: ScreenAccessibility {

    let name = TextAccessibility()
    let position = TextAccessibility()
}
```

Next, set accessibility keys to the components on the screen, using the key-paths from your scheme:

``` swift
struct UserView: View {

    let user: User

    var body: some View {
        VStack(spacing: .zero) {
            Text(user.name)
                .font(.largeTitle)
                // Set accessibility key for user name
                .accessibilityKey(\UserAccessibility.name)

            Text(user.position)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                // Set accessibility key for user position
                .accessibilityKey(\UserAccessibility.position)
                .padding(.top, 4)
        }
    }
}
```

Now your screen is ready for UI testing. You can write tests as follows:

``` swift
@MainActor
final class UserScreenTests: XCTestCase {

    let application = XCUIApplication()

    func testThatUserTitleIsCorrect() {
        application.launch()

        application
            .screen(of: UserAccessibility.self) // get the user screen
            .name // get the name component
            .waitForExistence() // wait for component to appear
            .assert(text: "Steve Jobs") // verify name
    }

    func testThatUserPositionIsCorrect() {
        application.launch()

        application
            .screen(of: UserAccessibility.self) // get the user screen
            .position // get the position component
            .waitForText("CEO") // wait for position text
    }
}
```


### Example App
[Example app](Example) is a simple iOS and tvOS app that demonstrates how Rafinad works in practice.
It's also a good place to start playing with the framework.


## Communication
- If you need help, open an issue.
- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request.

📬 Feel free to reach out to us on Telegram. We're here to help: https://t.me/hh_tech


## License
Rafinad is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
