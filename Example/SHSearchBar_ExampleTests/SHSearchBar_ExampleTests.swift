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


class SHSearchBarSpec: QuickSpec {

    override func spec() {

        let attributes = [
            NSForegroundColorAttributeName:UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor()]
        let config: SHSearchBarConfig = SHSearchBarConfig(animationDuration: 0.25, rasterSize: 11.0, textAttributes: attributes)
        let emptyDelegate = SearchBarEmptyDelegate()

        describe("searchbar") {
            var searchbar: SearchBarMock!

            beforeEach({
                searchbar = SearchBarMock(config: config)
                searchbar.delegate = emptyDelegate
            })

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
                expect(searchbar.textField.text).to(equal(textBefore))
                searchbar.textField.text = "Another text"
                expect(searchbar.textField.text).toNot(equal(textBefore))
                searchbar.resetTextField()
                expect(searchbar.textField.text).to(equal(textBefore))
            }
            it("sets a delegate on its textfield") {
                expect(searchbar.textField.delegate).toNot(beNil())
            }
            it("sets the correct text color when active") {
                let color = searchbar.textField.textColor
                let expectedColor = config.textAttributes[NSForegroundColorAttributeName] as? UIColor
                expect(color).to(equal(expectedColor))
            }
            it("sets the correct tint color when active") {
                let color = searchbar.textField.tintColor
                let expectedColor = config.textAttributes[NSForegroundColorAttributeName] as? UIColor
                expect(color).to(equal(expectedColor))
            }
            it("sets the correct textAttributes when active") {
                let attributes = searchbar.textField.defaultTextAttributes
                let expected = config.textAttributes

                for key in expected.keys {
                    guard let value = attributes[key], let expectedValue = expected[key] else {
                        XCTFail("Value or expected value not found for key \(key)")
                        return
                    }
                    expect(value).to(be(expectedValue))
                }
            }
            it("sets the correct text color when inactive") {
                searchbar.isActive = false
                let color = searchbar.textField.textColor
                let expectedColor = (config.textAttributes[NSForegroundColorAttributeName] as? UIColor)?.colorWithAlphaComponent(0.5)
                expect(color).to(equal(expectedColor))
            }
            it("sets the correct tint color when inactive") {
                searchbar.isActive = false
                let color = searchbar.textField.tintColor
                let expectedColor = (config.textAttributes[NSForegroundColorAttributeName] as? UIColor)?.colorWithAlphaComponent(0.5)
                expect(color).to(equal(expectedColor))
            }
            it("sets the correct textAttributes when inactive") {
                searchbar.isActive = false
                let attributes = searchbar.textField.defaultTextAttributes
                var expected = config.textAttributes
                expected[NSForegroundColorAttributeName] = (expected[NSForegroundColorAttributeName] as? UIColor)?.colorWithAlphaComponent(0.5)

                for key in expected.keys {
                    guard let value = attributes[key], let expectedValue = expected[key] else {
                        XCTFail("Value or expected value not found for key \(key)")
                        return
                    }
                    expect(value).to(be(expectedValue))
                }
            }
        }

        describe("textFieldDelegate") {

            context("searchBarDelegate is set to always true delegate") {
                var searchbar: SearchBarMock!
                var alwaysTrueDelegate: SearchBarAlwaysTrueDelegate!

                beforeEach({
                    alwaysTrueDelegate = SearchBarAlwaysTrueDelegate()
                    searchbar = SearchBarMock(config: config)
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
                var searchbar: SearchBarMock!
                var alwaysFalseDelegate: SearchBarAlwaysFalseDelegate!

                beforeEach({
                    alwaysFalseDelegate = SearchBarAlwaysFalseDelegate()
                    searchbar = SearchBarMock(config: config)
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
                var searchbar: SearchBarMock!
                var alwaysTrueDelegate: SearchBarAlwaysTrueDelegate!

                beforeEach({
                    alwaysTrueDelegate = SearchBarAlwaysTrueDelegate()
                    searchbar = SearchBarMock(config: config)
                    searchbar.delegate = alwaysTrueDelegate
                })

                it("it sets the cancelButton visibility to true") {
                    searchbar.textFieldShouldBeginEditing(searchbar.textField)
                    expect(searchbar.cancelButton.alpha).toEventually(equal(1))
                }
            }

            context("editing ends") {
                var searchbar: SearchBarMock!
                var alwaysTrueDelegate: SearchBarAlwaysTrueDelegate!

                beforeEach({
                    alwaysTrueDelegate = SearchBarAlwaysTrueDelegate()
                    searchbar = SearchBarMock(config: config)
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
                var searchbar: SearchBarMock!

                beforeEach({
                    searchbar = SearchBarMock(config: config)
                    searchbar.delegate = emptyDelegate
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
                var searchbar: SearchBarMock!

                beforeEach({
                    searchbar = SearchBarMock(config: config)
                    searchbar.delegate = emptyDelegate
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
                var searchbar: SearchBarMock!

                beforeEach({
                    searchbar = SearchBarMock(config: config)
                    searchbar.delegate = emptyDelegate
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
