//
//  SHSearchBar_ExampleTests.swift
//  SHSearchBar_ExampleTests
//
//  Created by Stefan Herold on 16/08/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import SHSearchBar

class Box<T> {
    let value: T
    init(value: T) {
        self.value = value
    }
}

class SHSearchBarSpec: QuickSpec {

    override func spec() {
        let delegate: SearchBarConcreteDelegate! = SearchBarConcreteDelegate()
        let config: SHSearchBarConfig = {
            var config = SHSearchBarConfig()
            config.cancelButtonTitle = "Abortar"
            config.cancelButtonTextColor = UIColor.redColor()
            config.textContentType = UITextContentTypeFullStreetAddress
            return config
        }()

        // TODO: Test updating config (test if SHSearchBarTextField is layouted again and that in SHSearchbar all parameters that are based on config are updated)

        describe("searchbar") {

            it("calls updateUI exactly once after init") {
                let config = SHSearchBarConfig()
                let searchbar = SHSearchBarMock(config: config)
                expect(searchbar.callCountUpdateUI) == 1
            }

            context("when active") {

                context("and the default config values are used") {
                    let config = SHSearchBarConfig()
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: true] }
                }

                context("and rasterSize is set") {
                    var config = SHSearchBarConfig()
                    config.rasterSize = 22.0
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: true] }
                }

                context("and textContentType is set") {
                    var config = SHSearchBarConfig()
                    config.textContentType = UITextContentTypeFullStreetAddress
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: true] }
                }

                context("and textColor is set") {
                    var config = SHSearchBarConfig()
                    config.textColor = UIColor.blackColor()
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: true] }
                }

                context("and textBackgroundColor is set") {
                    var config = SHSearchBarConfig()
                    config.textBackgroundColor = UIColor.redColor()
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: true] }
                }

                context("and cancelButtonTitle is set") {
                    var config = SHSearchBarConfig()
                    config.cancelButtonTitle = "Hello Cancel Button"
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: true] }
                }

                context("and cancelButtonTextColor is set") {
                    var config = SHSearchBarConfig()
                    config.cancelButtonTextColor = UIColor.purpleColor()
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: true] }
                }

                context("and updates the config") {
                    let config = SHSearchBarConfig()
                    let nonDefaultConfig = nonDefaultSearchbarConfig()
                    let boxedConfig = Box(value: nonDefaultConfig)
                    let searchbar = SHSearchBarMock(config: config)
                    searchbar.config = nonDefaultConfig
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: true, SharedConfiguration.ContextKey.searchbar: searchbar] }
                }
            }

            context("when inactive") {

                context("and the default config values are used") {
                    let config = SHSearchBarConfig()
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: false] }
                }

                context("and rasterSize is set") {
                    var config = SHSearchBarConfig()
                    config.rasterSize = 22.0
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: false] }
                }

                context("and textContentType is set") {
                    var config = SHSearchBarConfig()
                    config.textContentType = UITextContentTypeFullStreetAddress
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: false] }
                }

                context("and textColor is set") {
                    var config = SHSearchBarConfig()
                    config.textColor = UIColor.blackColor()
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: false] }
                }

                context("and textBackgroundColor is set") {
                    var config = SHSearchBarConfig()
                    config.textBackgroundColor = UIColor.redColor()
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: false] }
                }

                context("and cancelButtonTitle is set") {
                    var config = SHSearchBarConfig()
                    config.cancelButtonTitle = "Hello Cancel Button"
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: false] }
                }

                context("and cancelButtonTextColor is set") {
                    var config = SHSearchBarConfig()
                    config.cancelButtonTextColor = UIColor.purpleColor()
                    let boxedConfig = Box(value: config)
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: false] }
                }

                context("and updates the config") {
                    let config = SHSearchBarConfig()
                    let nonDefaultConfig = nonDefaultSearchbarConfig()
                    let boxedConfig = Box(value: nonDefaultConfig)
                    let searchbar = SHSearchBarMock(config: config)
                    searchbar.config = nonDefaultConfig
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: boxedConfig, SharedConfiguration.ContextKey.isActive: false, SharedConfiguration.ContextKey.searchbar: searchbar] }
                }
            }
        }

        describe("textFieldDelegate") {

            context("searchBarDelegate is set to always true delegate") {
                var searchbar: SHSearchBarMock!
                var alwaysTrueDelegate: SearchBarAlwaysTrueDelegate!

                beforeEach({
                    alwaysTrueDelegate = SearchBarAlwaysTrueDelegate()
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = alwaysTrueDelegate
                })

                it("returns true for shouldBeginEditing") {
                    let result = searchbar.textFieldShouldBeginEditing(searchbar.textField)
                    expect(result) == true
                }
                it("returns true for shouldEndEditing") {
                    let result = searchbar.textFieldShouldEndEditing(searchbar.textField)
                    expect(result) == true
                }
                it("returns true for shouldChangeCharactersinRange") {
                    let result = searchbar.textField(searchbar.textField, shouldChangeCharactersInRange: NSMakeRange(0, 0), replacementString: "")
                    expect(result) == true
                }
                it("returns true for shouldClear") {
                    let result = searchbar.textFieldShouldClear(searchbar.textField)
                    expect(result) == true
                }
                it("returns true for shouldReturn") {
                    let result = searchbar.textFieldShouldReturn(searchbar.textField)
                    expect(result) == true
                }
                it("calls the textDidChange method when text changes") {
                    let replacement = (searchbar.textField.text ?? "") + " appended text"
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled).to(beFalse())
                    searchbar.textField(searchbar.textField, shouldChangeCharactersInRange: NSMakeRange(0, 0), replacementString:replacement)
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled).to(beTrue())
                }
                it("does NOT call the textDidChange method when new text is set programmatically") {
                    let newText = (searchbar.textField.text ?? "") + " appended text"
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled).to(beFalse())
                    searchbar.textField.text = newText
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled).to(beFalse())
                }
                it("does NOT call the textDidChange method when text actually not changes") {
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled).to(beFalse())
                    searchbar.textField(searchbar.textField, shouldChangeCharactersInRange: NSMakeRange(0, 0), replacementString: "")
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled).to(beFalse())
                }
            }

            context("searchBarDelegate is set to the always false delegate") {
                var searchbar: SHSearchBarMock!
                var alwaysFalseDelegate: SearchBarAlwaysFalseDelegate!

                beforeEach({
                    alwaysFalseDelegate = SearchBarAlwaysFalseDelegate()
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = alwaysFalseDelegate
                })

                it("returns false for shouldBeginEditing") {
                    let result = searchbar.textFieldShouldBeginEditing(searchbar.textField)
                    expect(result) == false
                }
                it("returns false for shouldEndEditing") {
                    let result = searchbar.textFieldShouldEndEditing(searchbar.textField)
                    expect(result) == false
                }
                it("returns false for shouldChangeCharactersinRange") {
                    let result = searchbar.textField(searchbar.textField, shouldChangeCharactersInRange: NSMakeRange(0, 0), replacementString: "")
                    expect(result) == false
                }
                it("returns false for shouldClear") {
                    let result = searchbar.textFieldShouldClear(searchbar.textField)
                    expect(result) == false
                }
                it("returns false for shouldReturn") {
                    let result = searchbar.textFieldShouldReturn(searchbar.textField)
                    expect(result) == false
                }
                it("does NOT call the textDidChange method when text changes") {
                    let replacement = (searchbar.textField.text ?? "") + " appended text"
                    expect(alwaysFalseDelegate.hasTextDidChangeBeenCalled).to(beFalse())
                    searchbar.textField(searchbar.textField, shouldChangeCharactersInRange: NSMakeRange(0, 0), replacementString:replacement)
                    expect(alwaysFalseDelegate.hasTextDidChangeBeenCalled).to(beFalse())
                }
            }

            context("editing begins") {
                var searchbar: SHSearchBarMock!
                var alwaysTrueDelegate: SearchBarAlwaysTrueDelegate!

                beforeEach({
                    alwaysTrueDelegate = SearchBarAlwaysTrueDelegate()
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = alwaysTrueDelegate
                })

                it("it sets the cancelButton visibility to true") {
                    searchbar.textFieldShouldBeginEditing(searchbar.textField)
                    expect(searchbar.cancelButton.alpha).toEventually(equal(1))
                }
            }

            context("editing ends") {
                var searchbar: SHSearchBarMock!
                var alwaysTrueDelegate: SearchBarAlwaysTrueDelegate!

                beforeEach({
                    alwaysTrueDelegate = SearchBarAlwaysTrueDelegate()
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = alwaysTrueDelegate
                })

                it("it sets the cancelButton visibility to false") {
                    searchbar.textFieldShouldEndEditing(searchbar.textField)
                    expect(searchbar.cancelButton.alpha).toEventually(equal(0))
                }
            }
        }

        describe("setting the cancel button visibility") {

            context("to false") {
                var searchbar: SHSearchBarMock!

                beforeEach({
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = delegate
                    searchbar.setCancelButtonVisibility(false)
                })

                it("results in a zero alpha value") {
                    expect(searchbar.cancelButton.alpha).toEventually(equal(0))
                }
                it("moves the cancel button out of the screen") {
                    expect(searchbar.bgToCancelButtonConstraint.active).toEventually(beFalse())
                }
                it("sizes the searchbar to its full width") {
                    expect(searchbar.bgToParentConstraint.active).toEventually(beTrue())
                }
            }

            context("to true") {
                var searchbar: SHSearchBarMock!

                beforeEach({
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = delegate
                    searchbar.setCancelButtonVisibility(true)
                })

                it("results in an alpha value of 1") {
                    expect(searchbar.cancelButton.alpha).toEventually(equal(1))
                }
                it("moves the cancel button into the screen") {
                    expect(searchbar.bgToCancelButtonConstraint.active).toEventually(beTrue())
                }
                it("makes the searchbar smaller to make place for the cancel button") {
                    expect(searchbar.bgToParentConstraint.active).toEventually(beFalse())
                }
            }

            context("do not set the visibility") {
                var searchbar: SHSearchBarMock!

                beforeEach({
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = delegate
                })

                it("results in an alpha value of 1") {
                    expect(searchbar.cancelButton.alpha).toEventually(equal(0))
                }
                it("moves the cancel button into the screen") {
                    expect(searchbar.bgToCancelButtonConstraint.active).toEventually(beFalse())
                }
                it("makes the searchbar smaller to make place for the cancel button") {
                    expect(searchbar.bgToParentConstraint.active).toEventually(beTrue())
                }
            }
        }
    }
}



class SharedConfiguration: QuickConfiguration {

    struct ContextKey {
        static let searchbar = "searchbar"
        static let searchbarConfig = "searchbar_config"
        static let isActive = "is_active"
    }

    static var searchBar = "it"

    override class func configure(configuration: Configuration) {
        sharedExamples(SharedConfiguration.searchBar) { (sharedExampleContext: SharedExampleContext) in
            var superview: UIView!
            var searchbar: SHSearchBarMock!
            var delegate: SearchBarConcreteDelegate!

            beforeEach {
                guard let unwrappedConfig = (sharedExampleContext()[SharedConfiguration.ContextKey.searchbarConfig] as? Box<SHSearchBarConfig>)?.value else {
                    XCTFail("Value \(sharedExampleContext()[SharedConfiguration.ContextKey.searchbarConfig]) not a valid SHSearchBarConfig.")
                    return
                }
                guard let unwrappedIsActive = sharedExampleContext()[SharedConfiguration.ContextKey.isActive] as? Bool else {
                    XCTFail("Value \(sharedExampleContext()[SharedConfiguration.ContextKey.isActive]) not a valid Bool.")
                    return
                }

                if let unwrappedSearchBar = sharedExampleContext()[SharedConfiguration.ContextKey.searchbar] as? SHSearchBarMock {
                    searchbar = unwrappedSearchBar
                } else {
                    searchbar = SHSearchBarMock(config: unwrappedConfig)
                }

                delegate = SearchBarConcreteDelegate()

                searchbar.isActive = unwrappedIsActive
                searchbar.delegate = delegate

                searchbar.removeFromSuperview()
                superview = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 44))
                superview.addSubview(searchbar)

                let constraints = [
                    searchbar.leftAnchor.constraintEqualToAnchor(superview.leftAnchor),
                    searchbar.rightAnchor.constraintEqualToAnchor(superview.rightAnchor),
                    searchbar.topAnchor.constraintEqualToAnchor(superview.topAnchor),
                    searchbar.bottomAnchor.constraintEqualToAnchor(superview.bottomAnchor),
                ]
                NSLayoutConstraint.activateConstraints(constraints)

                superview.layoutIfNeeded()
            }

            // Test the basics

            it("has a background view") {
                expect(searchbar.backgroundView).toNot(beNil())
            }
            it("has a background view that is an image view") {
                expect(searchbar.backgroundView).to(beAKindOf(UIImageView))
            }
            it("has a background view with userinteraction enabled") {
                expect(searchbar.backgroundView.userInteractionEnabled) == true
            }
            it("has an image on the background view") {
                expect(searchbar.backgroundView.image).toNot(beNil())
            }
            it("has only subviews where the translateAutoResizingMaskIntoConstraints property is false") {
                for subview in searchbar.subviews {
                    expect(subview.translatesAutoresizingMaskIntoConstraints) == false
                }
            }
            it("has a background view where all subview's translateAutoResizingMaskIntoConstraints property is false") {
                for subview in searchbar.backgroundView.subviews {
                    expect(subview.translatesAutoresizingMaskIntoConstraints) == false
                }
            }
            it("resets the textfield to the same text as it had right before editing") {
                let textBefore = "Hello TextField"
                searchbar.textField.text = textBefore
                searchbar.textFieldDidBeginEditing(searchbar.textField)
                expect(searchbar.textField.text) == textBefore
                searchbar.textField.text = "Another text"
                expect(searchbar.textField.text).toNot(equal(textBefore))
                searchbar.resetTextField()
                expect(searchbar.textField.text) == textBefore
            }
            it("calls textDidChange delegate when text actually changed after resetTextField()") {
                searchbar.textField.text = "\(NSDate().timeIntervalSince1970)"
                delegate.hasCalledTextDidChange = false // reset
                searchbar.resetTextField()
                expect(delegate.hasCalledTextDidChange) == true
            }
            it("does not call textDidChange delegate when text doesn't change after resetTextField()") {
                delegate.hasCalledTextDidChange = false // reset - just to be sure
                searchbar.resetTextField()
                expect(delegate.hasCalledTextDidChange) == false
            }
            it("sets a delegate on its textfield") {
                expect(searchbar.textField.delegate).toNot(beNil())
            }
            it("sets the textFields clipToBounds to true") {
                expect(searchbar.textField.clipsToBounds) == true
            }
            it("the cancel button is behind the textFields backgroundView") {
                let backgroundViewIndex = searchbar.subviews.indexOf(searchbar.backgroundView)
                let cancelButtonIndex = searchbar.subviews.indexOf(searchbar.cancelButton)
                expect(backgroundViewIndex).to(beGreaterThan(cancelButtonIndex))
            }
            it("sets a non zero frame to the searchbar") {
                expect(searchbar.frame) != CGRect.zero
            }
            it("sets a non zero frame to the cancel button") {
                expect(searchbar.cancelButton.frame) != CGRect.zero
            }
            it("sets the correct frame for the background image") {
                expect(searchbar.backgroundView.frame) == CGRect(x: 0, y: 0, width: searchbar.frame.width, height: searchbar.frame.height)
            }
            it("sets the correct frame for the text field") {
                expect(searchbar.textField.frame) == CGRect(x: 0, y: 0, width: searchbar.backgroundView.frame.width, height: searchbar.backgroundView.frame.height)
            }
            it("sets the correct frame for the cancel button") {
                let cancelButtonWidth = searchbar.cancelButton.frame.width
                expect(searchbar.cancelButton.frame) == CGRect(x: searchbar.frame.width-cancelButtonWidth, y: 0, width: cancelButtonWidth, height: searchbar.frame.height)
            }
            it("sets backgroundImageView to cancelbutton constraint correctly") {
                expect(searchbar.bgToCancelButtonConstraint.firstAnchor) == searchbar.backgroundView.rightAnchor
                expect(searchbar.bgToCancelButtonConstraint.secondAnchor) == searchbar.cancelButton.leftAnchor
                expect(searchbar.bgToCancelButtonConstraint.constant) == -searchbar.config.rasterSize
                expect(searchbar.bgToCancelButtonConstraint.active) == false
            }
            it("sets backgroundImageView to searchbar constraint correctly") {
                expect(searchbar.bgToParentConstraint.firstAnchor) == searchbar.backgroundView.rightAnchor
                expect(searchbar.bgToParentConstraint.secondAnchor) == searchbar.rightAnchor
                expect(searchbar.bgToParentConstraint.constant) == 0
                expect(searchbar.bgToParentConstraint.active) == true
            }


            // Set specifics that depend on active / non active state

            it("sets the correct text color") {
                let color = searchbar.textField.textColor
                var expectedColor = searchbar.config.textColor
                expectedColor = searchbar.isActive ? expectedColor : expectedColor.colorWithAlphaComponent(0.5)
                expect(color) == expectedColor
            }

            it("sets the correct tint color") {
                let color = searchbar.textField.tintColor
                var expectedColor = searchbar.config.textColor
                expectedColor = searchbar.isActive ? expectedColor : expectedColor.colorWithAlphaComponent(0.5)
                expect(color) == expectedColor
            }

            it("sets the correct textAttributes") {
                let attributes = searchbar.textField.defaultTextAttributes
                var expected = [NSForegroundColorAttributeName:searchbar.config.textColor,
                                NSBackgroundColorAttributeName:searchbar.config.textBackgroundColor]
                expected[NSForegroundColorAttributeName] = searchbar.isActive ? searchbar.config.textColor : searchbar.config.textColor.colorWithAlphaComponent(0.5)

                for key in expected.keys {
                    guard let value = attributes[key] as? UIColor, let expectedValue = expected[key] else {
                        XCTFail("Value or expected value not found for key \(key)")
                        return
                    }
                    expect(value) == expectedValue
                }
            }

            it("sets the correct textContentType") {
                guard let textContentType = searchbar.config.textContentType else {
                    expect(searchbar.textField.textContentType).to(beNil())
                    return
                }
                expect(searchbar.textField.textContentType) == textContentType
            }

            it("sets the correct cancel button title") {
                expect(searchbar.cancelButton.titleForState(.Normal)) == searchbar.config.cancelButtonTitle
            }

            it("sets the correct cancel button normal color") {
                expect(searchbar.cancelButton.titleColorForState(.Normal)) == searchbar.config.cancelButtonTextColor
            }
            it("sets the correct cancel button highlighted color") {
                expect(searchbar.cancelButton.titleColorForState(.Highlighted)) == searchbar.config.cancelButtonTextColor.colorWithAlphaComponent(0.75)
            }
        }
    }
}
