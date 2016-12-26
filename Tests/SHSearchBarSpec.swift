//
//  SHSearchBar_ExampleTests.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 16/08/16.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import SHSearchBar

class SHSearchBarSpec: QuickSpec {

    override func spec() {
        let delegate: SearchBarConcreteDelegate! = SearchBarConcreteDelegate()
        let config: SHSearchBarConfig = {
            var config = SHSearchBarConfig()
            config.cancelButtonTitle = "Abortar"
            config.cancelButtonTextAttributes = [NSForegroundColorAttributeName:UIColor.red]
            config.textContentType = UITextContentType.fullStreetAddress.rawValue
            return config
        }()
        var isActive: Bool = true

        describe("searchbar") {

            beforeEach {
                isActive = true
            }

            it("calls updateUI exactly once after init") {
                let config = SHSearchBarConfig()
                let searchbar = SHSearchBarMock(config: config)
                expect(searchbar.callCountUpdateUI) == 1
            }

            context("when active") {

                context("and the default config values are used") {
                    let config = SHSearchBarConfig()
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and rasterSize is set") {
                    var config = SHSearchBarConfig()
                    config.rasterSize = 22.0
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and textContentType is set") {
                    var config = SHSearchBarConfig()
                    config.textContentType = UITextContentType.fullStreetAddress.rawValue
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and textColor is set") {
                    var config = SHSearchBarConfig()
                    config.textAttributes = [NSForegroundColorAttributeName:UIColor.black]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and textBackgroundColor is set") {
                    var config = SHSearchBarConfig()
                    config.textAttributes = [NSBackgroundColorAttributeName:UIColor.red]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and cancelButtonTitle is set") {
                    var config = SHSearchBarConfig()
                    config.cancelButtonTitle = "Hello Cancel Button"
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and cancelButtonTextColor is set") {
                    var config = SHSearchBarConfig()
                    config.cancelButtonTextAttributes = [NSForegroundColorAttributeName:UIColor.purple]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and leftView is set") {
                    var config = SHSearchBarConfig()
                    config.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and rightView is set") {
                    var config = SHSearchBarConfig()
                    config.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and updates the config") {
                    let config = SHSearchBarConfig()
                    let nonDefaultConfig = nonDefaultSearchbarConfig()
                    let searchbar = SHSearchBarMock(config: config)
                    searchbar.config = nonDefaultConfig
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive,
                                                                    SharedConfiguration.ContextKey.searchbar: searchbar] }
                }
            }

            context("when inactive") {

                beforeEach {
                    isActive = false
                }

                context("and the default config values are used") {
                    let config = SHSearchBarConfig()
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and rasterSize is set") {
                    var config = SHSearchBarConfig()
                    config.rasterSize = 22.0
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and textContentType is set") {
                    var config = SHSearchBarConfig()
                    config.textContentType = UITextContentType.fullStreetAddress.rawValue
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and textColor is set") {
                    var config = SHSearchBarConfig()
                    config.textAttributes = [NSForegroundColorAttributeName:UIColor.black]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and textBackgroundColor is set") {
                    var config = SHSearchBarConfig()
                    config.textAttributes = [NSBackgroundColorAttributeName:UIColor.red]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and cancelButtonTitle is set") {
                    var config = SHSearchBarConfig()
                    config.cancelButtonTitle = "Hello Cancel Button"
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and cancelButtonTextColor is set") {
                    var config = SHSearchBarConfig()
                    config.cancelButtonTextAttributes = [NSForegroundColorAttributeName:UIColor.purple]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and leftView is set") {
                    var config = SHSearchBarConfig()
                    config.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and rightView is set") {
                    var config = SHSearchBarConfig()
                    config.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive] }
                }

                context("and updates the config") {
                    let config = SHSearchBarConfig()
                    let nonDefaultConfig = nonDefaultSearchbarConfig()
                    let searchbar = SHSearchBarMock(config: config)
                    searchbar.config = nonDefaultConfig
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: nonDefaultConfig,
                                                                    SharedConfiguration.ContextKey.isActive: isActive,
                                                                    SharedConfiguration.ContextKey.searchbar: searchbar] }
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
                    let result = searchbar.textField(searchbar.textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
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
                    _ = searchbar.textField(searchbar.textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: replacement)
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
                    _ = searchbar.textField(searchbar.textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
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
                    let result = searchbar.textField(searchbar.textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
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
                    _ = searchbar.textField(searchbar.textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: replacement)
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
                    _ = searchbar.textFieldShouldBeginEditing(searchbar.textField)
                })

                it("it sets the cancelButton visibility to true") {
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
                    _ = searchbar.textFieldShouldEndEditing(searchbar.textField)
                })

                it("it sets the cancelButton visibility to false") {
                    expect(searchbar.cancelButton.alpha).toEventually(equal(0))
                }
            }
        }

        describe("pressing the cancelButton") {
            var searchbar: SHSearchBarMock!

            beforeEach({
                searchbar = SHSearchBarMock(config: config)
                searchbar.delegate = delegate
            })

            it("calls searchBarShouldCancel delegate") {
                searchbar.pressedCancelButton(UIButton())
                expect(delegate.callCountSearchBarShouldCancel) == 1
            }
            it("calls resetTextField with delegate set and searchBarShouldCancel returning true") {
                searchbar.pressedCancelButton(UIButton())
                expect(searchbar.callCountResetTextField) == 1
            }
            it("calls resetTextField with delegate nil") {
                searchbar.delegate = nil
                searchbar.pressedCancelButton(UIButton())
                expect(searchbar.callCountResetTextField) == 1
            }
        }

        describe("setting the cancel button visibility") {

            context("to false") {
                var searchbar: SHSearchBarMock!

                beforeEach({
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = delegate
                    searchbar.updateCancelButtonVisibility(makeVisible: false)
                })

                it("results in a zero alpha value") {
                    expect(searchbar.cancelButton.alpha).toEventually(equal(0))
                }
                it("moves the cancel button out of the screen") {
                    expect(searchbar.bgToCancelButtonConstraint.isActive).toEventually(beFalse())
                }
                it("sizes the searchbar to its full width") {
                    expect(searchbar.bgToParentConstraint.isActive).toEventually(beTrue())
                }
            }

            context("to true") {
                var searchbar: SHSearchBarMock!

                beforeEach({
                    searchbar = SHSearchBarMock(config: config)
                    searchbar.delegate = delegate
                    searchbar.updateCancelButtonVisibility(makeVisible: true)
                })

                it("results in an alpha value of 1") {
                    expect(searchbar.cancelButton.alpha).toEventually(equal(1))
                }
                it("moves the cancel button into the screen") {
                    expect(searchbar.bgToCancelButtonConstraint.isActive).toEventually(beTrue())
                }
                it("makes the searchbar smaller to make place for the cancel button") {
                    expect(searchbar.bgToParentConstraint.isActive).toEventually(beFalse())
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
                    expect(searchbar.bgToCancelButtonConstraint.isActive).toEventually(beFalse())
                }
                it("makes the searchbar smaller to make place for the cancel button") {
                    expect(searchbar.bgToParentConstraint.isActive).toEventually(beTrue())
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

    override class func configure(_ configuration: Configuration) {
        sharedExamples(SharedConfiguration.searchBar) { (sharedExampleContext: @escaping SharedExampleContext) in
            var superview: UIView!
            var searchbar: SHSearchBarMock!
            var delegate: SearchBarConcreteDelegate!

            beforeEach {
                guard let unwrappedConfig = sharedExampleContext()[SharedConfiguration.ContextKey.searchbarConfig] as? SHSearchBarConfig else {
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
                    searchbar.leftAnchor.constraint(equalTo: superview.leftAnchor),
                    searchbar.rightAnchor.constraint(equalTo: superview.rightAnchor),
                    searchbar.topAnchor.constraint(equalTo: superview.topAnchor),
                    searchbar.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                ]
                NSLayoutConstraint.activate(constraints)

                superview.layoutIfNeeded()
            }

            // Test the basics

            it("has a background view") {
                expect(searchbar.backgroundView).toNot(beNil())
            }
            it("has a background view that is an image view") {
                expect(searchbar.backgroundView).to( beAKindOf(UIImageView.self) )
            }
            it("has a background view with userinteraction enabled") {
                expect(searchbar.backgroundView.isUserInteractionEnabled) == true
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
                let backgroundViewIndex = searchbar.subviews.index(of: searchbar.backgroundView)
                let cancelButtonIndex = searchbar.subviews.index(of: searchbar.cancelButton)
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
            it("sets BackgroundImageView-To-Cancelbutton-Constraint correctly") {
                expect(searchbar.bgToCancelButtonConstraint.firstAnchor) == searchbar.backgroundView.rightAnchor
                expect(searchbar.bgToCancelButtonConstraint.secondAnchor) == searchbar.cancelButton.leftAnchor
                expect(searchbar.bgToCancelButtonConstraint.constant) == -searchbar.config.rasterSize
                expect(searchbar.bgToCancelButtonConstraint.isActive) == false
            }
            it("sets BackgroundImageView-To-Searchbar-Constraint correctly") {
                expect(searchbar.bgToParentConstraint.firstAnchor) == searchbar.backgroundView.rightAnchor
                expect(searchbar.bgToParentConstraint.secondAnchor) == searchbar.rightAnchor
                expect(searchbar.bgToParentConstraint.constant) == 0
                expect(searchbar.bgToParentConstraint.isActive) == true
            }
            it("sets textFields leftView correctly") {
                if searchbar.config.leftView == nil {
                    expect(searchbar.textField.leftView).to(beNil())
                } else {
                    expect(searchbar.textField.leftView) == searchbar.config.leftView
                }
            }
            it("sets textFields rightView correctly") {
                if searchbar.config.rightView == nil {
                    expect(searchbar.textField.rightView).to(beNil())
                } else {
                    expect(searchbar.textField.rightView) == searchbar.config.rightView
                }
            }


            // Set specifics that depend on active / non active state

            it("sets the correct text color") {
                let color = searchbar.textField.textColor
                let expectedTextColor = searchbar.config.textAttributes[NSForegroundColorAttributeName] as? UIColor ?? SHSearchBarConfig.defaultTextForegroundColor
                expect(color) == (searchbar.isActive ? expectedTextColor : expectedTextColor.withAlphaComponent(0.5))
            }

            it("sets the correct tint color") {
                let color = searchbar.textField.tintColor
                let expectedTextColor = searchbar.config.textAttributes[NSForegroundColorAttributeName] as? UIColor ?? SHSearchBarConfig.defaultTextForegroundColor
                expect(color) == (searchbar.isActive ? expectedTextColor : expectedTextColor.withAlphaComponent(0.5))
            }

            it("sets the correct textAttributes") {
                let attributes = searchbar.textField.defaultTextAttributes
                var expected = searchbar.config.textAttributes
                let expectedTextColor = expected[NSForegroundColorAttributeName] as? UIColor
                expected[NSForegroundColorAttributeName] = searchbar.isActive ? expectedTextColor : expectedTextColor?.withAlphaComponent(0.5)

                for key in expected.keys {
                    guard let value = attributes[key] as? UIColor, let expectedValue = expected[key] as? UIColor else {
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
                expect(searchbar.textField.textContentType.rawValue) == textContentType
            }

            it("sets the correct cancel button title in normal mode") {
                let expectedTitle = NSAttributedString(string: searchbar.config.cancelButtonTitle, attributes: searchbar.config.cancelButtonTextAttributes)
                expect(searchbar.cancelButton.attributedTitle(for: .normal)) == expectedTitle
            }
            it("sets the correct cancel button title highlighted mode") {
                var highlightedAttributes = searchbar.config.cancelButtonTextAttributes
                let highlightedColor = highlightedAttributes[NSForegroundColorAttributeName] as? UIColor ?? SHSearchBarConfig.defaultTextForegroundColor
                highlightedAttributes[NSForegroundColorAttributeName] = highlightedColor.withAlphaComponent(0.75)
                let expectedTitle = NSAttributedString(string: searchbar.config.cancelButtonTitle, attributes: highlightedAttributes)
                expect(searchbar.cancelButton.attributedTitle(for: .highlighted)) == expectedTitle
            }
        }
    }
}
