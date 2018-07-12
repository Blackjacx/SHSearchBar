
<!-- <p align="center">
<img src="./icon.png" alt="SHSearchBar" height="128" width="128">
</p> -->

<h1 align="center">SHSearchBar</h1>

<p align="center">
  <a href="https://github.com/Blackjacx/SHSearchBar"><img alt="Build Status" src="https://www.bitrise.io/app/582435533da6e6e8/status.svg?token=txPO2FVRfVTh3wS57eoOuw&branch=develop"/></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar"><img alt="Version" src="https://cocoapod-badges.herokuapp.com/v/SHSearchBar/badge.svg"/></a>
  <img alt="Xcode 9.0+" src="https://img.shields.io/badge/Xcode-9.0%2B-blue.svg"/>
  <img alt="iOS 9.0+" src="https://img.shields.io/badge/iOS-9.0%2B-blue.svg"/>
  <img alt="Swift 4.0+" src="https://img.shields.io/badge/Swift-4.0%2B-orange.svg"/>
  <!-- <a href="https://github.com/Carthage/Carthage"><img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat"/></a> -->
  <a href="https://github.com/Blackjacx/SHSearchBar/blob/develop/LICENSE?raw=true"><img alt="License" src="https://img.shields.io/cocoapods/l/SHSearchBar.svg?style=flat"/></a>
  <a href="https://codecov.io/gh/blackjacx/SHSearchBar"><img alt="Codecov" src="https://codecov.io/gh/blackjacx/SHSearchBar/branch/master/graph/badge.svg"/></a>
  <a href="https://codebeat.co/projects/github-com-blackjacx-shsearchbar"><img alt="Codebeat" src="https://codebeat.co/badges/44539071-5029-4379-9d33-99dd721915c8" /></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar/"><img alt="Downloads" src="https://img.shields.io/cocoapods/dt/SHSearchBar.svg?maxAge=3600&style=flat" /></a>
  <a href="https://www.paypal.me/STHEROLD"><img alt="Donate" src="https://img.shields.io/badge/Donate-PayPal-blue.svg"/></a>
</p>

The clean and shiny search bar that does what UISearchBar does only with dirty 
hacks. This view is designed to tackle the customization limits of UISearchBar. 
The difference here is that this class does not inherit UISearchBar but 
composes a new UIView object by using a UITextField that is much easier to use. 
These are the limits of the UISearchBar:

- no clean way to left align the placeholder
- the cancel button is hard to taylor to your needs
- generally the appearance is not customizable (e.g. the font of the text)
- there are some strange behaviours when you set a custom background image

Since I use a UITextField these restrictions do not apply.

## Installation

SHSearchBar is compatible with `iOS 9` or higher and builds with `Xcode 9` 
and `Swift 4` syntax. It is available through [CocoaPods](http://cocoapods.org). 
To install it, simply add the following line to your Podfile:

```ruby
pod "SHSearchBar"
```

## Examples

The repo includes an example project. It shows shows different use cases of 
the searchbar. To run it, just type `pod try SHSearchBar` in your console and 
it will be cloned and opened for you. The following images show some of these 
use cases:

<p align="center">
<caption align="center">You can show a custom placeholder like for normal text fields:</caption><br />
<img src="./github/assets/example_01.png" alt="Placeholder">
</p>

<p align="center">
<caption align="center">And you can even type text into that searchbar:</caption><br />
<img src="./github/assets/example_02.png" alt="Text">
</p>

<p align="center">
<caption align="center">Wow there are customizable accessory views too:</caption><br />
<img src="./github/assets/example_03.png" alt="Accesssory Icon">
</p>

<p align="center">
<caption align="center">Easily customize text and cancel button as you want:</caption><br />
<img src="./github/assets/example_04.png" alt="Customizable text and ancel button">
</p>

<p align="center">
<caption align="center">You can customize each corner radius of the text field so that layouts like this become an ease:</caption><br />
<img src="./github/assets/example_06.png" alt="Corner Radius Customization">
</p>

<p align="center">
<caption align="center">The inner text field supports the new iOS 10 'textContentMode':<br />(Re-uses the address searched in Apple Maps before)</caption><br />
<img src="./github/assets/example_05.png" alt="UITextContentMode Support">
</p>

<p align="center">
<caption align="center">You can use the search bar inside a UINavigationBar:</caption><br />
<img src="./github/assets/example_07.png" alt="UINavigationBar Support">
</p>

## Contribution

- If you found a **bug**, open an **issue**
- If you have a **feature request**, open an **issue**
- If you want to **contribute**, submit a **pull request**

## Author

Stefan Herold, stefan.herold@gmail.com

## License

SHSearchBar is available under the MIT license. See the LICENSE file for more 
info.
