//
//  Mocks.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 21/08/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class SHSearchBarMock: SHSearchBar {
    var callCountUpdateUI = 0
    override func updateUI() {
        super.updateUI()
        callCountUpdateUI += 1
    }

    var callCountSetCancelButtonVisibility = 0
    override func setCancelButtonVisibility(makeVisible: Bool) {
        super.setCancelButtonVisibility(makeVisible)
        callCountSetCancelButtonVisibility += 1
    }
}

class SearchBarConcreteDelegate: NSObject, SHSearchBarDelegate {
    var hasCalledTextDidChange = false
    func searchBar(searchBar: SHSearchBar, textDidChange text: String) {
        hasCalledTextDidChange = true
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
