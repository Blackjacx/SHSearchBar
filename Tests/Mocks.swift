//
//  Mocks.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 21/08/2016.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import UIKit

func nonDefaultSearchbarConfig() -> SHSearchBarConfig {
    var config = SHSearchBarConfig()
    config.rasterSize = 15.0
    config.animationDuration = 10.0
    config.cancelButtonTextAttributes = [NSForegroundColorAttributeName:UIColor.orange]
    config.cancelButtonTitle = "foo bar"
    config.textAttributes = [NSForegroundColorAttributeName:UIColor.brown, NSBackgroundColorAttributeName:UIColor.gray]
    return config
}

class SHSearchBarMock: SHSearchBar {
    var callCountUpdateUI = 0
    override func updateUserInterface() {
        super.updateUserInterface()
        callCountUpdateUI += 1
    }

    var callCountResetTextField = 0
    override func resetTextField() {
        super.resetTextField()
        callCountResetTextField += 1
    }

    var callCountUpdateCancelButtonVisibility = 0
    override func updateCancelButtonVisibility(makeVisible show: Bool) {
        super.updateCancelButtonVisibility(makeVisible: show)
        callCountUpdateCancelButtonVisibility += 1
    }
}

class SearchBarConcreteDelegate: NSObject, SHSearchBarDelegate {
    var hasCalledTextDidChange = false
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        hasCalledTextDidChange = true
    }

    var callCountSearchBarShouldCancel = 0
    var mockSearchBarShouldCancelReturnValue = true
    func searchBarShouldCancel(_ searchBar: SHSearchBar) -> Bool {
        callCountSearchBarShouldCancel += 1
        return mockSearchBarShouldCancelReturnValue
    }
}

class SearchBarAlwaysFalseDelegate: NSObject, SHSearchBarDelegate {
    var hasTextDidChangeBeenCalled: Bool = false

    // UITextField Pendants
    @objc func searchBarShouldBeginEditing(_ searchBar: SHSearchBar) -> Bool {
        return false
    }
    @objc func searchBarShouldEndEditing(_ searchBar: SHSearchBar) -> Bool {
        return false
    }
    @objc func searchBar(_ searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    @objc func searchBarShouldClear(_ searchBar: SHSearchBar) -> Bool {
        return false
    }
    @objc func searchBarShouldReturn(_ searchBar: SHSearchBar) -> Bool {
        return false
    }
    @objc func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        hasTextDidChangeBeenCalled = true
    }
}

class SearchBarAlwaysTrueDelegate: NSObject, SHSearchBarDelegate {
    var hasTextDidChangeBeenCalled: Bool = false

    // UITextField Pendants
    @objc func searchBarShouldBeginEditing(_ searchBar: SHSearchBar) -> Bool {
        return true
    }
    @objc func searchBarShouldEndEditing(_ searchBar: SHSearchBar) -> Bool {
        return true
    }
    @objc func searchBar(_ searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    @objc func searchBarShouldClear(_ searchBar: SHSearchBar) -> Bool {
        return true
    }
    @objc func searchBarShouldReturn(_ searchBar: SHSearchBar) -> Bool {
        return true
    }
    @objc func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        hasTextDidChangeBeenCalled = true
    }
}
