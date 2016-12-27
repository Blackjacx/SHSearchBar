# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
- translations for DE, EN, ES, FR, IT, JA, ZH-HANS, RU (#15)
- first responder handling by forwarding related calls directly to the textfield

### Changed
- improves code documentation (#2)
- adopts swift 3 naming conventions (#14)
- replaces non-swifty implementation of optional SHSearchBarDelegate methods by a default implementation of each method on a protocol extension
- resigns and resets the textField per default when pressing cancel button
- left and right view is now property of the config object
- replaces textColor and textBackgroundColor with textAttributes in config

### Fixed
- cancellation in the example project
- resolves but did not fix SPM support (#6)

### Removed
- boxed type from specs since Swift3 uses Any for dictionary values that includes structs
