# Change Log

## [Unreleased]
* [#50](https://github.com/Blackjacx/SHSearchBar/pull/50): Update readme badges - [@blackjacx](https://github.com/blackjacx).

## [1.7.0] - 2019-05-05
* [#49](https://github.com/Blackjacx/SHSearchBar/pull/49): Swift 5 Compatibility - [@blackjacx](https://github.com/blackjacx).

## [1.6.0] - 2018-12-18
* [#47](https://github.com/Blackjacx/SHSearchBar/pull/47): Carthage Support - [@blackjacx](https://github.com/blackjacx).
* [#46](https://github.com/Blackjacx/SHSearchBar/pull/46): Extending Example App - [@blackjacx](https://github.com/blackjacx).
* Add AUTHORS file - [@blackjacx](https://github.com/blackjacx).

## [1.5.0] - 2018-09-25
* [#41](https://github.com/Blackjacx/SHSearchBar/pull/41): Swift 4.2 - [@blackjacx](https://github.com/blackjacx).

## [1.4.3] - 2018-07-12
* [#39](https://github.com/Blackjacx/SHSearchBar/pull/39): Make localized extension internal - [@blackjacx](https://github.com/blackjacx).

## [1.4.2] - 2018-07-12
* [#38](https://github.com/Blackjacx/SHSearchBar/pull/38): Make String Extension `localized` Internal To Avoid Naming Conflicts - [@blackjacx](https://github.com/blackjacx).

## [1.4.1] - 2018-02-16
* [#33](https://github.com/Blackjacx/SHSearchBar/pull/33): Fix Pod Try To Quick Try Pod Example - [@blackjacx](https://github.com/blackjacx).
* Add example for search bar in UINavigationBar - [@blackjacx](https://github.com/blackjacx).

## [1.4.0] - 2017-11-22
### Changed
* [#31](https://github.com/Blackjacx/SHSearchBar/pull/31): Refactor Text Did Change Delegation - [@blackjacx](https://github.com/blackjacx).

### Fixed
* [#29](https://github.com/Blackjacx/SHSearchBar/pull/29): Italian localization - [@CeceXX](https://github.com/CeceXX).

## [1.3.0] - 2017-10-26
### Changed
* [#28](https://github.com/Blackjacx/SHSearchBar/pull/28): Make it possible to avoid internal cancel button - [@blackjacx](https://github.com/blackjacx).

## [1.2.1] - 2017-10-16
### Changed
* Update podspec by removing non-source from sources. - [@blackjacx](https://github.com/blackjacx).

## [1.2.0] - 2017-09-29
### Added
* [#15](https://github.com/Blackjacx/SHSearchBar/pull/15): translations for DE, EN, ES, FR, IT, JA, ZH-HANS, RU - [@blackjacx](https://github.com/blackjacx).
* first responder handling by forwarding related calls directly to the textfield - [@blackjacx](https://github.com/blackjacx).

### Changed
* [#26](https://github.com/Blackjacx/SHSearchBar/pull/26): Conversion to Swift 4 - [@blackjacx](https://github.com/blackjacx).
* [#2](https://github.com/Blackjacx/SHSearchBar/pull/2): improves code documentation - [@blackjacx](https://github.com/blackjacx).
* [#14](https://github.com/Blackjacx/SHSearchBar/pull/14): adopts swift 3 naming conventions - [@blackjacx](https://github.com/blackjacx).
* Replaces non-swifty implementation of optional SHSearchBarDelegate methods by a default implementation of each method on a protocol extension - [@blackjacx](https://github.com/blackjacx).
* Resigns and resets the textField per default when pressing cancel button - [@blackjacx](https://github.com/blackjacx).
* Left and right view is now property of the config object - [@blackjacx](https://github.com/blackjacx).
* Replaces textColor and textBackgroundColor with textAttributes in config - [@blackjacx](https://github.com/blackjacx).

### Fixed
* Cancellation in the example project - [@blackjacx](https://github.com/blackjacx).
* [#6](https://github.com/Blackjacx/SHSearchBar/pull/6): resolves but did not fix SPM support - [@blackjacx](https://github.com/blackjacx).

### Removed
* Boxed type from specs since Swift3 uses Any for dictionary values that includes structs - [@blackjacx](https://github.com/blackjacx).
