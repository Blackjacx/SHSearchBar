//
//  SHSearchBar_ExampleTests.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 16/08/16.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Quick
import Nimble
import XCTest

@testable import SHSearchBar

func expectedDefaultConfig() -> SHSearchBarConfig {

    var config = SHSearchBarConfig()
    config.animationDuration = 0.25
    config.rasterSize = 11.0
    config.textAttributes = [.foregroundColor: SHSearchBarConfig.defaultTextForegroundColor]
    config.textContentType = nil
    config.cancelButtonTitle = "sb.general.cancel".localized
    config.cancelButtonTextAttributes = [.foregroundColor: SHSearchBarConfig.defaultTextForegroundColor]
    config.leftView = nil
    config.leftViewMode = .never
    config.rightView = nil
    config.rightViewMode = .never
    config.clearButtonMode = .whileEditing
    return config
}

class SHSearchBarSpec: QuickSpec {

    // swiftlint:disable:next function_body_length
    override func spec() {
        let delegate: SearchBarConcreteDelegate! = SearchBarConcreteDelegate()
        var config: SHSearchBarConfig = SHSearchBarConfig()
        var nonDefaultConfig = nonDefaultSearchbarConfig()
        var searchbar = SHSearchBarMock(config: config)
        var isActive: Bool = true

        describe("searchbar") {

            beforeEach {
                config = SHSearchBarConfig()
                isActive = true
            }

            it("calls updateUI exactly once after init") {
                let searchbar = SHSearchBarMock(config: config)
                expect(searchbar.callCountUpdateUI) == 1
            }

            context("when active") {

                context("and rasterSize is set") {
                    config.rasterSize = 22.0
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and textContentType is set") {
                    config.textContentType = UITextContentType.fullStreetAddress.rawValue
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and textColor is set") {
                    config.textAttributes = [.foregroundColor: UIColor.black]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and textBackgroundColor is set") {
                    config.textAttributes = [.backgroundColor: UIColor.red]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and cancelButtonTitle is set") {
                    config.cancelButtonTitle = "Hello Cancel Button"
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and cancelButtonTextColor is set") {
                    config.cancelButtonTextAttributes = [.foregroundColor: UIColor.purple]
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and leftView is set") {
                    beforeEach {
                        config.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and rightView is set") {
                    beforeEach {
                        config.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    }
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and leftViewMode is set") {
                    config.leftViewMode = .always
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and rightViewMode is set") {
                    config.rightViewMode = .always
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and clearButtonMode is set") {
                    config.clearButtonMode = .always
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and updates the config") {
                    beforeEach {
                        let nonDefaultConfig = nonDefaultSearchbarConfig()
                        searchbar = SHSearchBarMock(config: config)
                        searchbar.config = nonDefaultConfig
                    }
                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive,
                                                                    SharedConfiguration.ContextKey.searchbar: searchbar]
                    }
                }
            }

            context("when inactive") {

                beforeEach {
                    isActive = false
                }

                context("and rasterSize is set") {
                    beforeEach {
                        config.rasterSize = 22.0
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and textContentType is set") {
                    beforeEach {
                        config.textContentType = UITextContentType.fullStreetAddress.rawValue
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and textColor is set") {
                    beforeEach {
                        config.textAttributes = [.foregroundColor: UIColor.black]
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and textBackgroundColor is set") {
                    beforeEach {
                        config.textAttributes = [.backgroundColor: UIColor.red]
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and cancelButtonTitle is set") {
                    beforeEach {
                        config.cancelButtonTitle = "Hello Cancel Button"
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and cancelButtonTextColor is set") {
                    beforeEach {
                        config.cancelButtonTextAttributes = [.foregroundColor: UIColor.purple]
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and leftView is set") {
                    beforeEach {
                        config.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and rightView is set") {
                    beforeEach {
                        config.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and leftViewMode is set") {
                    beforeEach {
                        config.leftViewMode = .always
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and rightViewMode is set") {
                    beforeEach {
                        config.rightViewMode = .always
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and clearButtonMode is set") {
                    beforeEach {
                        config.clearButtonMode = .always
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: config,
                                                                    SharedConfiguration.ContextKey.isActive: isActive]
                    }
                }

                context("and updates the config") {
                    beforeEach {
                        nonDefaultConfig = nonDefaultSearchbarConfig()
                        searchbar = SHSearchBarMock(config: config)
                        searchbar.config = nonDefaultConfig
                    }

                    itBehavesLike(SharedConfiguration.searchBar) { [SharedConfiguration.ContextKey.searchbarConfig: nonDefaultConfig,
                                                                    SharedConfiguration.ContextKey.isActive: isActive,
                                                                    SharedConfiguration.ContextKey.searchbar: searchbar]
                    }
                }
            }
        }

        describe("textFieldDelegate") {

            beforeEach {
                config = SHSearchBarConfig()
                config.cancelButtonTitle = "Abortar"
                config.cancelButtonTextAttributes = [.foregroundColor: UIColor.red]
                config.textContentType = UITextContentType.fullStreetAddress.rawValue
            }

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
                    let range = NSRange(location: 0, length: 0)
                    let result = searchbar.textField(searchbar.textField,
                                                     shouldChangeCharactersIn: range,
                                                     replacementString: "")
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
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled) == false
                    searchbar.didChangeTextField(UITextField())
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled) == true
                }
                it("does NOT call the textDidChange method when new text is set programmatically") {
                    let newText = (searchbar.textField.text ?? "") + " appended text"
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled) == false
                    searchbar.textField.text = newText
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled) == false
                }
                it("does NOT call the textDidChange method when text actually not changes") {
                    let range = NSRange(location: 0, length: 0)
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled) == false
                    _ = searchbar.textField(searchbar.textField,
                                            shouldChangeCharactersIn: range,
                                            replacementString: "")
                    expect(alwaysTrueDelegate.hasTextDidChangeBeenCalled) == false
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
                    let range = NSRange(location: 0, length: 0)
                    let result = searchbar.textField(searchbar.textField,
                                                     shouldChangeCharactersIn: range,
                                                     replacementString: "")
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
                    let range = NSRange(location: 0, length: 0)
                    expect(alwaysFalseDelegate.hasTextDidChangeBeenCalled) == false
                    _ = searchbar.textField(searchbar.textField,
                                            shouldChangeCharactersIn: range,
                                            replacementString: replacement)
                    expect(alwaysFalseDelegate.hasTextDidChangeBeenCalled) == false
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

final class SharedConfiguration: QuickConfiguration {

    enum ContextKey {
        static let searchbar = "searchbar"
        static let searchbarConfig = "searchbar_config"
        static let isActive = "is_active"
    }

    static var searchBar = "it"

    // swiftlint:disable:next function_body_length
    override class func configure(_ configuration: QCKConfiguration) {
        sharedExamples(SharedConfiguration.searchBar) { (sharedExampleContext: @escaping SharedExampleContext) in
            var superview: UIView!
            var searchbar: SHSearchBarMock!
            var delegate: SearchBarConcreteDelegate!

            beforeEach {
                let key = SharedConfiguration.ContextKey.searchbarConfig
                guard let unwrappedConfig = sharedExampleContext()[key] as? SHSearchBarConfig else {
                    let key = SharedConfiguration.ContextKey.searchbarConfig
                    if let value = sharedExampleContext()[key] {
                        fail("Value \(value) not a valid SHSearchBarConfig.")
                    } else {
                        fail("Value for key \(key) was nil!")
                    }
                    return
                }

                guard let unwrappedIsActive = sharedExampleContext()[SharedConfiguration.ContextKey.isActive] as? Bool else {
                    let key = SharedConfiguration.ContextKey.isActive
                    if let value = sharedExampleContext()[key] {
                        fail("Value \(value) not a valid Bool.")
                    } else {
                        fail("Value for key \(key) was nil!")
                    }
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
                    searchbar.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                    searchbar.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                    searchbar.topAnchor.constraint(equalTo: superview.topAnchor),
                    searchbar.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
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
                expect(searchbar.textField.text) != textBefore
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
                let backgroundViewIndex = searchbar.subviews.firstIndex(of: searchbar.backgroundView)
                let cancelButtonIndex = searchbar.subviews.firstIndex(of: searchbar.cancelButton) ?? 0
                expect(backgroundViewIndex) > cancelButtonIndex
            }
            it("sets a non zero frame to the searchbar") {
                expect(searchbar.frame) != CGRect.zero
            }
            it("sets a non zero frame to the cancel button") {
                expect(searchbar.cancelButton.frame) != CGRect.zero
            }
            it("sets the correct frame for the background image") {
                expect(searchbar.backgroundView.frame) == CGRect(x: 0,
                                                                 y: 0,
                                                                 width: searchbar.frame.width,
                                                                 height: searchbar.frame.height)
            }
            it("sets the correct frame for the text field") {
                expect(searchbar.textField.frame) == CGRect(x: 0,
                                                            y: 0,
                                                            width: searchbar.backgroundView.frame.width,
                                                            height: searchbar.backgroundView.frame.height)
            }
            it("sets the correct frame for the cancel button") {
                let cancelButtonWidth = searchbar.cancelButton.frame.width
                expect(searchbar.cancelButton.frame) == CGRect(x: searchbar.frame.width - cancelButtonWidth,
                                                               y: 0,
                                                               width: cancelButtonWidth,
                                                               height: searchbar.frame.height)
            }
            it("sets BackgroundImageView-To-Cancelbutton-Constraint correctly") {
                expect(searchbar.bgToCancelButtonConstraint.firstAnchor) == searchbar.backgroundView.trailingAnchor
                expect(searchbar.bgToCancelButtonConstraint.secondAnchor) == searchbar.cancelButton.leadingAnchor
                expect(searchbar.bgToCancelButtonConstraint.constant) == -searchbar.config.rasterSize
                expect(searchbar.bgToCancelButtonConstraint.isActive) == false
            }
            it("sets BackgroundImageView-To-Searchbar-Constraint correctly") {
                expect(searchbar.bgToParentConstraint.firstAnchor) == searchbar.backgroundView.trailingAnchor
                expect(searchbar.bgToParentConstraint.secondAnchor) == searchbar.trailingAnchor
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
            it("sets textFields leftViewMode correctly") {
                expect(searchbar.textField.leftViewMode) == searchbar.config.leftViewMode
            }
            it("sets textFields rightViewMode correctly") {
                expect(searchbar.textField.rightViewMode) == searchbar.config.rightViewMode
            }
            it("sets textFields clearButtonMode correctly") {
                expect(searchbar.textField.clearButtonMode) == searchbar.config.clearButtonMode
            }

            // Set specifics that depend on active / non active state

            it("sets the correct text color") {
                let color = searchbar.textField.textColor
                let expectedTextColor = searchbar.config.textAttributes[.foregroundColor] as? UIColor ??
                    SHSearchBarConfig.defaultTextForegroundColor
                expect(color) == (searchbar.isActive ? expectedTextColor : expectedTextColor.withAlphaComponent(0.5))
            }

            it("sets the correct tint color") {
                let color = searchbar.textField.tintColor
                let expectedTextColor = searchbar.config.textAttributes[.foregroundColor] as? UIColor ??
                    SHSearchBarConfig.defaultTextForegroundColor
                expect(color) == (searchbar.isActive ? expectedTextColor : expectedTextColor.withAlphaComponent(0.5))
            }

            it("sets the correct textAttributes") {
                let attributes = searchbar.textField.defaultTextAttributes
                var expected = searchbar.config.textAttributes
                let expectedTextColor = expected[.foregroundColor] as? UIColor
                expected[.foregroundColor] = searchbar.isActive ? expectedTextColor : expectedTextColor?.withAlphaComponent(0.5)

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
                let expectedTitle = NSAttributedString(string: searchbar.config.cancelButtonTitle,
                                                       attributes: searchbar.config.cancelButtonTextAttributes)
                expect(searchbar.cancelButton.attributedTitle(for: .normal)) == expectedTitle
            }
            it("sets the correct cancel button title highlighted mode") {
                var highlightedAttributes = searchbar.config.cancelButtonTextAttributes
                let highlightedColor = highlightedAttributes[.foregroundColor] as? UIColor ?? SHSearchBarConfig.defaultTextForegroundColor
                highlightedAttributes[.foregroundColor] = highlightedColor.withAlphaComponent(0.75)
                let expectedTitle = NSAttributedString(string: searchbar.config.cancelButtonTitle, attributes: highlightedAttributes)
                expect(searchbar.cancelButton.attributedTitle(for: .highlighted)) == expectedTitle
            }
        }
    }
}
