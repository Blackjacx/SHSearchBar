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

        describe("searchbar") {
            var searchbar: SearchBarMock!

            beforeEach({
                searchbar = SearchBarMock()
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
        }

        describe("textField") {
            var searchbar: SearchBarMock!

            beforeEach({
                searchbar = SearchBarMock()
            })

            it("has a non nil delegate") {
                expect(searchbar.textField.delegate).toNot(beNil())
            }
        }

        describe("internal textFieldDelegate") {

            context("searchBarDelegate is set to nil") {
                var searchbar: SearchBarMock!

                beforeEach({
                    searchbar = SearchBarMock()
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
            }

            context("searchBarDelegate is set to always true delegate") {
                var searchbar: SearchBarMock!
                var alwaysTrueDelegate: SearchBarAlwaysTrueDelegate!

                beforeEach({
                    alwaysTrueDelegate = SearchBarAlwaysTrueDelegate()
                    searchbar = SearchBarMock(delegate: alwaysTrueDelegate)
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
                    searchbar = SearchBarMock(delegate: alwaysFalseDelegate)
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

                beforeEach({
                    searchbar = SearchBarMock(delegate: SearchBarAlwaysTrueDelegate())
                })

                it("it sets the cancelButton visibility to true") {
                    searchbar.textFieldShouldBeginEditing(searchbar.textField)
                    expect(searchbar.cancelButton.alpha).toEventually(equal(1))
                }
            }

            context("editing ends") {
                var searchbar: SearchBarMock!

                beforeEach({
                    searchbar = SearchBarMock(delegate: SearchBarAlwaysTrueDelegate())
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
                    searchbar = SearchBarMock()
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
                    searchbar = SearchBarMock()
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
                    searchbar = SearchBarMock()
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

class SearchBarMock: SHSearchBar {

    init(delegate: SHSearchBarDelegate? = nil) {
        let config = SHSearchBarConfig(animationDuration: 1234, rasterSize: 4321)
        super.init(config: config, delegate: delegate)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchBarAlwaysFalseDelegate: NSObject, SHSearchBarDelegate {
    var hasTextDidChangeBeenCalled: Bool = false

    // UITextField Pendants
    @objc func searchBarShouldBeginEditing(searchBar: SHSearchBar) -> Bool {
        return false
    }
    @objc func searchBarShouldEndEditing(searchBar: SHSearchBar) -> Bool {
        return false
    }
    @objc func searchBar(searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    @objc func searchBarShouldClear(searchBar: SHSearchBar) -> Bool {
        return false
    }
    @objc func searchBarShouldReturn(searchBar: SHSearchBar) -> Bool {
        return false
    }
    @objc func searchBar(searchBar: SHSearchBar, textDidChange text: String) {
        hasTextDidChangeBeenCalled = true
    }
}

class SearchBarAlwaysTrueDelegate: NSObject, SHSearchBarDelegate {
    var hasTextDidChangeBeenCalled: Bool = false

    // UITextField Pendants
    @objc func searchBarShouldBeginEditing(searchBar: SHSearchBar) -> Bool {
        return true
    }
    @objc func searchBarShouldEndEditing(searchBar: SHSearchBar) -> Bool {
        return true
    }
    @objc func searchBar(searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    @objc func searchBarShouldClear(searchBar: SHSearchBar) -> Bool {
        return true
    }
    @objc func searchBarShouldReturn(searchBar: SHSearchBar) -> Bool {
        return true
    }
    @objc func searchBar(searchBar: SHSearchBar, textDidChange text: String) {
        hasTextDidChangeBeenCalled = true
    }
}
