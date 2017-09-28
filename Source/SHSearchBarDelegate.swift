//
//  SHSearchBarDelegate.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 04.05.17.
//  Copyright © 2017 StefanHerold. All rights reserved.
//

import Foundation

/**
 * This protocol is used to inform the searchbar's delegate of important events.
 */
public protocol SHSearchBarDelegate : NSObjectProtocol {
    /**
     * Controls whether editing should begin or not. Return false to disallow editing.
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     * - returns: Whether or not to allow begin editing.
     */
    func searchBarShouldBeginEditing(_ searchBar: SHSearchBar) -> Bool

    /**
     * Informs the delegate that editing has begun. The searchbar has become first responder in that case.
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     */
    func searchBarDidBeginEditing(_ searchBar: SHSearchBar)

    /**
     * Controls whether editing should end or not.
     * Return true to allow editing to stop and to resign first responder status.
     * Return false to disallow the editing session to end
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     * - returns: Whether or not to allow end editing.
     */
    func searchBarShouldEndEditing(_ searchBar: SHSearchBar) -> Bool

    /**
     * Informs the delegate that editing has ended. The searchbar has resigned first responder in that case.
     * - note: May be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called.
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     */
    func searchBarDidEndEditing(_ searchBar: SHSearchBar)

    /**
     * Controls whether the currently edited character or range of characters should be changed or not.
     * You can use this method to restrict entry of certain characters, e.g. for entering phone numbers.
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     * - parameter range: The range of the respective characters.
     * - parameter string: The string the characters in 'range' should be replaced with.
     * - returns: False when you don't want to change the characters. True when the change is ok.
     */
    func searchBar(_ searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool

    /**
     * Called when the clear button is pressed to delete all contents of the searchbar.
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     * - returns: False when you want to ignore the button press.
     */
    func searchBarShouldClear(_ searchBar: SHSearchBar) -> Bool

    /**
     * Called when the keyboards return button is pressed.
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     * - returns: False when you want to ignore the button press.
     */
    func searchBarShouldReturn(_ searchBar: SHSearchBar) -> Bool

    /**
     * Called when the cancel button is pressed.
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     * - returns: False when you want to ignore the button press.
     */
    func searchBarShouldCancel(_ searchBar: SHSearchBar) -> Bool

    /**
     * Called when the text in the searchbar did change
     * - parameter searchBar: The searchbar for which the delegate call was issued.
     * - parameter text: The new text after the change.
     */
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String)
}


/**
 * This extension provides a default implementation of the protocol which replaces old-style optional protocol methods known from Objective-C.
 * (http://useyourloaf.com/blog/swift-optional-protocol-methods/)
 */
extension SHSearchBarDelegate {
    public func searchBarShouldBeginEditing(_ searchBar: SHSearchBar) -> Bool {
        return true
    }

    public func searchBarDidBeginEditing(_ searchBar: SHSearchBar) {}

    public func searchBarShouldEndEditing(_ searchBar: SHSearchBar) -> Bool {
        return true
    }

    public func searchBarDidEndEditing(_ searchBar: SHSearchBar) {}

    public func searchBar(_ searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    public func searchBarShouldClear(_ searchBar: SHSearchBar) -> Bool {
        return true
    }

    public func searchBarShouldReturn(_ searchBar: SHSearchBar) -> Bool {
        searchBar.textField.resignFirstResponder()
        return true
    }

    public func searchBarShouldCancel(_ searchBar: SHSearchBar) -> Bool {
        return true
    }

    public func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {}
}
