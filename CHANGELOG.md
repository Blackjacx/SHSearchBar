# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

- improves code documentation - #2
- adopts swift 3 naming conventions - #14
- implements first responder handling by delegate calls to relevant methods to the textfield
- replaces non-swifty implementation of optional SHSearchBarDelegate methods by a default implementation of each method on a protocol extension
- resigns and resets the textField per default when pressing cancel button
- left and right view is now property of the config object
- fixes cancellation in the example project
- replaces textColor and textBackgroundColor with textAttributes in config
- removes boxed type from specs since Swift3 uses Any for dictionary values that includes structs
- resolves but did not fix #6 (SPM support)