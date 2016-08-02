# SHSearchBar

[![CI Status](http://img.shields.io/travis/Stefan Herold/SHSearchBar.svg?style=flat)](https://travis-ci.org/Stefan Herold/SHSearchBar)
[![Version](https://img.shields.io/cocoapods/v/SHSearchBar.svg?style=flat)](http://cocoapods.org/pods/SHSearchBar)
[![License](https://img.shields.io/cocoapods/l/SHSearchBar.svg?style=flat)](http://cocoapods.org/pods/SHSearchBar)
[![Platform](https://img.shields.io/cocoapods/p/SHSearchBar.svg?style=flat)](http://cocoapods.org/pods/SHSearchBar)

The clean and shiny search bar that does what UISearchBar does only with dirty hacks. This search bar class is designed to overcome the customization limits of UISearchBar. The difference here is that this class does not inherit UISearchBar but composes a new UIView object by using a UITextField that is much easier to use.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SHSearchBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SHSearchBar"
```

## Next Steps

- cancel button not yet shown
- complete the search bar class
- add support for a blurred background view
- create the example project
- add tests
- implement protocols: ShadowCaster, RectRounding including the protocol extensions that implement the methods behind it. So you can just conform any view to the protocol and it will have a default shadow/ round corners. PLus you will have control over the parameters via the protocol.
- test programmatic use
- implement storyboard support (low priority)

## Author

Stefan Herold, stefan.herold@gmail.com

## License

SHSearchBar is available under the MIT license. See the LICENSE file for more info.
