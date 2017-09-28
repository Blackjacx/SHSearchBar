# Change Log

## [Unreleased]
### Added
* [#15](https://github.com/Blackjacx/SHSearchBar/pull/15): translations for DE, EN, ES, FR, IT, JA, ZH-HANS, RU - [@blackjacx](https://github.com/blackjacx).
* first responder handling by forwarding related calls directly to the textfield - [@blackjacx](https://github.com/blackjacx).

### Changed
* [#26](https://github.com/Blackjacx/SHSearchBar/pull/26): Conversion to Swift 4 - [@blackjacx](https://github.com/blackjacx).
* [#2](https://github.com/Blackjacx/SHSearchBar/pull/2): improves code documentation - [@blackjacx](https://github.com/blackjacx).
* [#14](https://github.com/Blackjacx/SHSearchBar/pull/14): adopts swift 3 naming conventions - [@blackjacx](https://github.com/blackjacx).
* replaces non-swifty implementation of optional SHSearchBarDelegate methods by a default implementation of each method on a protocol extension - [@blackjacx](https://github.com/blackjacx).
* resigns and resets the textField per default when pressing cancel button - [@blackjacx](https://github.com/blackjacx).
* left and right view is now property of the config object - [@blackjacx](https://github.com/blackjacx).
* replaces textColor and textBackgroundColor with textAttributes in config - [@blackjacx](https://github.com/blackjacx).

### Fixed
* cancellation in the example project - [@blackjacx](https://github.com/blackjacx).
* [#6](https://github.com/Blackjacx/SHSearchBar/pull/6): resolves but did not fix SPM support - [@blackjacx](https://github.com/blackjacx).

### Removed
* boxed type from specs since Swift3 uses Any for dictionary values that includes structs - [@blackjacx](https://github.com/blackjacx).
