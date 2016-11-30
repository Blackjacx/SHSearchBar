# SHSearchBar


<!-- <p align="center">
  <img src="https://cloud.githubusercontent.com/assets/798235/19212170/781ebb64-8d4c-11e6-8285-94e74a356d53.png" alt="Reactions">
</p> -->

<p align="center">
  <a href="https://travis-ci.org/Blackjacx/SHSearchBar"><img alt="Build Status" src="http://img.shields.io/travis/Blackjacx/SHSearchBar.svg?style=flat"/></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar"><img alt="Version" src="https://cocoapod-badges.herokuapp.com/v/SHSearchBar/badge.svg"/></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar/"><img alt="Supported Platforms" src="https://cocoapod-badges.herokuapp.com/p/SHSearchBar/badge.svg"/></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar/"><img alt="License" src="https://img.shields.io/cocoapods/l/SHSearchBar.svg?style=flat"/></a>
  <a href="http://codecov.io/gh/blackjacx/SHSearchBar"><img alt="Code Coverage Status" src="http://codecov.io/gh/blackjacx/SHSearchBar/coverage.svg?branch=master"/></a>
  <a href="https://codebeat.co/projects/github-com-blackjacx-shsearchbar"><img alt="Codebeat" src="https://codebeat.co/badges/44539071-5029-4379-9d33-99dd721915c8" /></a>
</p>

The clean and shiny search bar that does what UISearchBar does only with dirty hacks. This search bar class is designed to overcome the customization limits of UISearchBar. The difference here is that this class does not inherit UISearchBar but composes a new UIView object by using a UITextField that is much easier to use. The limits of the search bar are as follows:

- no clean way to left align the placeholder
- the cancel button is hard to taylor to your needs
- generally the appearance is not customizable (e.g. the font of the text)
- there are some strange behaviours when you set a custom background image

Since I use a UITextField these restrictions do not apply.

## Installation

SHSearchBar is compatible with `iOS 8` or higher and build with `Xcode 8` and `Swift 2.3` syntax. It is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "SHSearchBar"
```

## Example

The repo includes an example project. It shows shows different use cases of the searchbar. To run it, clone the repo and run `pod install` from the Example directory first. The following images show some of these use cases:

<p align="center">
<caption align="center">You can show a custom placeholder like for normal text fields:</caption><br />
<img src="./assets/example_01.png" alt="Placeholder">
</p>

<p align="center">
<caption align="center">And you can even type text into that searchbar:</caption><br />
<img src="./assets/example_02.png" alt="Text">
</p>

<p align="center">
<caption align="center">Wow there are customizable accessory views too:</caption><br />
<img src="./assets/example_03.png" alt="Accesssory Icon">
</p>

<p align="center">
<caption align="center">Easily customize text and cancel button as you want:</caption><br />
<img src="./assets/example_04.png" alt="Customizable text and ancel button">
</p>

<p align="center">
<caption align="center">You can customize each corner radius of the text field so that layouts like this become an ease:</caption><br />
<img src="./assets/example_06.png" alt="Corner Radius Customization">
</p>

<p align="center">
<caption align="center">The inner text field supports the new iOS 10 'textContentMode':<br />(Re-uses the address searched in Apple Maps before)</caption><br />
<img src="./assets/example_05.png" alt="UITextContentMode Support">
</p>

## Author

Stefan Herold, stefan.herold@gmail.com

## License

SHSearchBar is available under the MIT license. See the LICENSE file for more info.
