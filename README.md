<!-- <p align="center">
<img src="./icon.png" alt="SHSearchBar" height="128" width="128">
</p> -->

<h1 align="center">SHSearchBar</h1>

<!--<a href="https://github.com/Blackjacx/shsearchbar/actions?query=workflow%3ACI"><img alt="CI status" src="https://github.com/blackjacx/shsearchbar/workflows/CI/badge.svg" /></a>-->
[![Twitter](https://img.shields.io/twitter/follow/blackjacxxx?label=%40Blackjacxxx)](https://twitter.com/blackjacxxx)
[![Version](https://shields.io/github/v/release/blackjacx/shsearchbar?display_name=tag&include_prereleases&sort=semver)](https://github.com/Blackjacx/shsearchbar/releases)
[![Swift Versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FBlackjacx%2FSHSearchBar%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Blackjacx/SHSearchBar)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FBlackjacx%2FSHSearchBar%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Blackjacx/SHSearchBar)
[![Codebeat](https://codebeat.co/badges/44539071-5029-4379-9d33-99dd721915c8)](https://codebeat.co/projects/github-com-blackjacx-shsearchbar)
[![License](https://img.shields.io/github/license/blackjacx/shsearchbar.svg)](https://github.com/blackjacx/shsearchbar/blob/develop/LICENSE)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://www.paypal.me/STHEROLD)

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

Since SHSearchBar uses localized resources I dropped CocoaPods support in favor of SPM from version `2.0.0`. 
Please integrate the package via SPM (see above).

### Carthage

Since SHSearchBar uses localized resources I dropped Carthage support in favor of SPM from version `2.0.0`. 
Please integrate the package via SPM (see above).

## Examples

The repo includes an example project. It shows shows different use cases of 
the search bar. To run it, just open and run `./Example/SHSearchBarExample.xcodeproj`. The following images show some
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

## Code Documentation

The [code documentation](https://swiftpackageindex.com/Blackjacx/SHSearchBar/develop/documentation/shsearchbar) is generated and hosted by [Swift Package Index](https://swiftpackageindex.com/) (powered by [DocC](https://developer.apple.com/documentation/docc))

## Release

To release this Swift package the following steps have to be taken:
- Create a new branch `release-x.y.z`
- Run `bash <(curl -H -s https://raw.githubusercontent.com/Blackjacx/Scripts/master/frameworks/bootstrap.sh)` to update to the latest shared development files
- Run `bundle update` to update all Ruby gems
- Commit all changes, make a PR and merge it to develop
- Run `bundle exec fastlane release framework:"SHSearchBar" version:"x.y.z"` to release the new version
- Post the following on Twitter
```
SHSearchBar release x.y.z 🎉

▸ 🚀  SHSearchBar (x.y.z) successfully published
▸ 📅  September 2nd
▸ 🌎  https://swiftpackageindex.com/Blackjacx/SHSearchBar
▸ 🌎  https://github.com/Blackjacx/SHSearchBar/releases/latest
▸ 👍  Tell your friends!

#spm #search #ios #apple #xcode #uisearchbar #swiftpackagemanager
```

## Contribution

- If you found a **bug**, please open an **issue**.
- If you have a **feature request**, please open an **issue**.
- If you want to **contribute**, please submit a **pull request**.

## Author

[Stefan Herold](mailto:stefan.herold@gmail.com) • 🐦 [@Blackjacxxx](https://twitter.com/Blackjacxxx)

## Contributors

Thanks to all of you who are part of this:

<a href="https://github.com/blackjacx/SHSearchBar/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=blackjacx/SHSearchBar" />
</a>

## License

SHSearchBar is available under the MIT license. See the [LICENSE](LICENSE) file for more info.