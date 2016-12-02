//
//  SHSearchBarTextFieldSpecs.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 01/12/2016.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import SHSearchBar


class SHSearchBarTextFieldSpec: QuickSpec {

    override func spec() {
        
        describe("textField") {
            var config: SHSearchBarConfig!
            let bounds: CGRect = CGRect(x: 0, y: 0, width: 353, height: 44)
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 44))
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 44))
            var textField: SHSearchBarTextField!
            var expectedRect: CGRect!

            beforeEach({
                config = SHSearchBarConfig()
                textField = SHSearchBarTextField(config: config)
                textField.leftViewMode = .Always
                textField.rightViewMode = .Always
            })

            context("with no accessory views") {

                beforeEach({
                    expectedRect = CGRect(x: config.rasterSize, y: 0, width: bounds.width - config.rasterSize * 2, height: bounds.height)
                })

                it("calculates the correct textRectForBounds") {
                    expect(textField.textRectForBounds(bounds)) == expectedRect
                }

                it("calculates the correct editingRectForBounds") {
                    expect(textField.editingRectForBounds(bounds)) == expectedRect
                }
            }

            context("with left accessory view") {

                beforeEach({
                    textField.leftView = leftView
                    expectedRect = CGRect(x: leftView.bounds.width, y: 0, width: bounds.width - leftView.bounds.width - config.rasterSize, height: bounds.height)
                })

                it("calculates the correct textRectForBounds") {
                    expect(textField.textRectForBounds(bounds)) == expectedRect
                }

                it("calculates the correct editingRectForBounds") {
                    expect(textField.editingRectForBounds(bounds)) == expectedRect
                }
            }

            context("with right accessory view") {

                beforeEach({
                    textField.rightView = leftView
                    expectedRect = CGRect(x: config.rasterSize, y: 0, width: bounds.width - rightView.bounds.width - config.rasterSize, height: bounds.height)
                })

                it("calculates the correct textRectForBounds") {
                    expect(textField.textRectForBounds(bounds)) == expectedRect
                }

                it("calculates the correct editingRectForBounds") {
                    expect(textField.editingRectForBounds(bounds)) == expectedRect
                }
            }

            context("with left and right accessory views") {
                
                beforeEach({
                    textField.leftView = leftView
                    textField.rightView = rightView
                    expectedRect = CGRect(x: leftView.bounds.width, y: 0, width: bounds.width - leftView.bounds.width - leftView.bounds.width, height: bounds.height)
                })
                
                it("calculates the correct textRectForBounds") {
                    expect(textField.textRectForBounds(bounds)) == expectedRect
                }
                
                it("calculates the correct editingRectForBounds") {
                    expect(textField.editingRectForBounds(bounds)) == expectedRect
                }
            }
        }
    }
}

