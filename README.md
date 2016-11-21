# SHSearchBar

[![CI Status](http://img.shields.io/travis/Blackjacx/SHSearchBar.svg?style=flat)](https://travis-ci.org/Blackjacx/SHSearchBar)
[![Version](https://img.shields.io/cocoapods/v/SHSearchBar.svg?style=flat)](http://cocoapods.org/pods/SHSearchBar)
[![License](https://img.shields.io/cocoapods/l/SHSearchBar.svg?style=flat)](http://cocoapods.org/pods/SHSearchBar)
[![Platform](https://img.shields.io/cocoapods/p/SHSearchBar.svg?style=flat)](http://cocoapods.org/pods/SHSearchBar)

The clean and shiny search bar that does what UISearchBar does only with dirty hacks. This search bar class is designed to overcome the customization limits of UISearchBar. The difference here is that this class does not inherit UISearchBar but composes a new UIView object by using a UITextField that is much easier to use. The limits of the search bar are as follows:

- no clean way to left align the placeholder
- the cancel button is hard to taylor to your needs
- generally the appearance is not customizable (e.g. the font of the text)
- there are some strange behaviours when you set a custom background image

Since I use a UITextField these restrictions do not apply.

## Example

The example project shows different use cases of the searchbar. To run it, clone the repo, and run `pod install` from the Example directory first.

## Installation

SHSearchBar is compatible with `iOS 8` or higher and build with `Xcode 8` and the newest `Swift 2.3` syntax. It is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "SHSearchBar"
```

## Next Steps

- solve the scaling text on textField width animation bug when there are multiple SHSearchBars on the same view (like in the example)
- put the examples with images in this readme
- add support for a blurred dim view
- test programmatic use

## Author

Stefan Herold, stefan.herold@gmail.com

## License

SHSearchBar is available under the MIT license. See the LICENSE file for more info.
