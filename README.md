<!-- <p align="center">
<img src="./icon.png" alt="SHSearchBar" height="128" width="128">
</p> -->

<h1 align="center">SHSearchBar</h1>

[![Twitter](https://img.shields.io/twitter/follow/blackjacxxx?label=%40Blackjacxxx)](https://twitter.com/blackjacx)
<a href="https://github.com/Blackjacx/shsearchbar/actions?query=workflow%3ACI"><img alt="CI status" src="https://github.com/blackjacx/shsearchbar/workflows/CI/badge.svg" /></a>
<img alt="Github Current Release" src="https://img.shields.io/github/release/blackjacx/SHSearchBar.svg" /> 
<img alt="Cocoapods Platforms" src="https://img.shields.io/cocoapods/p/SHSearchBar.svg"/>
<img alt="Xcode 12.0+" src="https://img.shields.io/badge/Xcode-12.0%2B-blue.svg"/>
<img alt="iOS 10.0+" src="https://img.shields.io/badge/iOS-10.0%2B-blue.svg"/>
<img alt="Swift 5.3+" src="https://img.shields.io/badge/Swift-5.3%2B-orange.svg"/>
<img alt="Github Repo Size" src="https://img.shields.io/github/repo-size/blackjacx/SHSearchBar.svg" />
<img alt="Github Code Size" src="https://img.shields.io/github/languages/code-size/blackjacx/SHSearchBar.svg" />
<img alt="Github Closed PR's" src="https://img.shields.io/github/issues-pr-closed/blackjacx/SHSearchBar.svg" />
<a href="https://github.com/Carthage/Carthage"><img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat"/></a>
<a href="https://github.com/Blackjacx/SHSearchBar/blob/develop/LICENSE?raw=true"><img alt="License" src="https://img.shields.io/cocoapods/l/SHSearchBar.svg?style=flat"/></a>
<a href="https://codebeat.co/projects/github-com-blackjacx-shsearchbar"><img alt="Codebeat" src="https://codebeat.co/badges/44539071-5029-4379-9d33-99dd721915c8" /></a>
<a href="https://www.paypal.me/STHEROLD"><img alt="Donate" src="https://img.shields.io/badge/Donate-PayPal-blue.svg"/></a>

The clean and shiny search bar that does what UISearchBar does only with dirty 
hacks. This view is designed to tackle the customization limits of UISearchBar. 
The difference here is that this class does not inherit UISearchBar but 
composes a new UIView object by using a UITextField that is much easier to use. 
These are the limits of the UISearchBar:

- no clean way to left align the placeholder
- the cancel button is hard to tailor to your needs
- generally the appearance is not customizable (e.g. the font of the text)
- there are some strange behaviors when you set a custom background image

Since I use a UITextField these restrictions do not apply.

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

In Xcode open your target list and select your project. Click the tab `Swift 
Packages` and there the small `+` icon. Enter the URL of this repository, 
select the version you want to install - usually the preset is okay - and 
confirm.

### [CocoaPods](http://cocoapods.org)

Since SHSearchBar uses localized resources I dropped CocoaPods support in favor for SPM from version `2.0.0`. 
Please integrate the package via SPM (see above).

### Carthage

Since SHSearchBar uses localized resources I dropped Carthage support in favor for SPM version `2.0.0`. 
Please integrate the package via SPM (see above).

## Examples

The repo includes an example project. It shows shows different use cases of 
the searchbar. To run it, just type `pod try SHSearchBar` in your console and 
it will be cloned and opened for you. The following images show some of these 
use cases:

<p align="center">
<caption align="center">You can show a custom placeholder like for normal text fields:</caption><br />
<img src="./.github/assets/example_01.png" alt="Placeholder">
</p>

<p align="center">
<caption align="center">And you can even type text into that searchbar:</caption><br />
<img src="./.github/assets/example_02.png" alt="Text">
</p>

<p align="center">
<caption align="center">Wow there are customizable accessory views too:</caption><br />
<img src="./.github/assets/example_03.png" alt="Accesssory Icon">
</p>

<p align="center">
<caption align="center">Easily customize text and cancel button as you want:</caption><br />
<img src="./.github/assets/example_04.png" alt="Customizable text and ancel button">
</p>

<p align="center">
<caption align="center">You can customize each corner radius of the text field so that layouts like this become an ease:</caption><br />
<img src="./.github/assets/example_06.png" alt="Corner Radius Customization">
</p>

<p align="center">
<caption align="center">The inner text field supports the new iOS 10 'textContentMode':<br />(Re-uses the address searched in Apple Maps before)</caption><br />
<img src="./.github/assets/example_05.png" alt="UITextContentMode Support">
</p>

<p align="center">
<caption align="center">You can use the search bar inside a UINavigationBar:</caption><br />
<img src="./.github/assets/example_07.png" alt="UINavigationBar Support">
</p>

## Contribution

- If you found a **bug**, please open an **issue**.
- If you have a **feature request**, please open an **issue**.
- If you want to **contribute**, please submit a **pull request**.

## Author

[Stefan Herold](mailto:stefan.herold@gmail.com) • 🐦 [@Blackjacxxx](https://twitter.com/Blackjacxxx)

## License

SHSearchBar is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
