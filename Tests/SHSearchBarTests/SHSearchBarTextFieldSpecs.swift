//
//  SHSearchBarTextFieldSpecs.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 01/12/2016.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import SHSearchBar

final class SHSearchBarTextFieldSpec: QuickSpec {

    // swiftlint:disable:next function_body_length
    override func spec() {

        var config: SHSearchBarConfig!
        let bounds: CGRect = CGRect(x: 0, y: 0, width: 353, height: 44)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 44))
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 44))
        var textField: SHSearchBarTextField!
        var expectedRect: CGRect!

        describe("textField") {

            beforeEach {
                config = SHSearchBarConfig()
                textField = SHSearchBarTextField(config: config)
                textField.leftViewMode = .always
                textField.rightViewMode = .always
            }

            context("with no accessory views") {

                beforeEach {
                    expectedRect = CGRect(x: config.rasterSize, y: 0, width: bounds.width - config.rasterSize * 2, height: bounds.height)
                }

                it("calculates the correct textRectForBounds") {
                    expect(textField.textRect(forBounds: bounds)) == expectedRect
                }

                it("calculates the correct editingRectForBounds") {
                    expect(textField.editingRect(forBounds: bounds)) == expectedRect
                }
            }

            context("with left accessory view") {

                beforeEach {
                    textField.leftView = leftView
                    expectedRect = CGRect(x: leftView.bounds.width,
                                          y: 0,
                                          width: bounds.width - leftView.bounds.width - config.rasterSize,
                                          height: bounds.height)
                }

                it("calculates the correct textRectForBounds") {
                    expect(textField.textRect(forBounds: bounds)) == expectedRect
                }

                it("calculates the correct editingRectForBounds") {
                    expect(textField.editingRect(forBounds: bounds)) == expectedRect
                }
            }

            context("with right accessory view") {

                beforeEach {
                    textField.rightView = leftView
                    expectedRect = CGRect(x: config.rasterSize,
                                          y: 0,
                                          width: bounds.width - rightView.bounds.width - config.rasterSize,
                                          height: bounds.height)
                }

                it("calculates the correct textRectForBounds") {
                    expect(textField.textRect(forBounds: bounds)) == expectedRect
                }

                it("calculates the correct editingRectForBounds") {
                    expect(textField.editingRect(forBounds: bounds)) == expectedRect
                }
            }

            context("with left and right accessory views") {

                beforeEach {
                    textField.leftView = leftView
                    textField.rightView = rightView
                    expectedRect = CGRect(x: leftView.bounds.width,
                                          y: 0,
                                          width: bounds.width - leftView.bounds.width - leftView.bounds.width,
                                          height: bounds.height)
                }

                it("calculates the correct textRectForBounds") {
                    expect(textField.textRect(forBounds: bounds)) == expectedRect
                }

                it("calculates the correct editingRectForBounds") {
                    expect(textField.editingRect(forBounds: bounds)) == expectedRect
                }
            }
        }
    }
}
