//
//  SHSearchBar.swift
//  Pods
//
//  Created by Stefan Herold on 01/08/16.
//
//

import UIKit

public class SHSearchBar: UIView, UITextFieldDelegate {
    private var textField: UITextField = UITextField()
    private var cancelButton: UIButton = UIButton(type: .custom)
    
    // Constraints for showing and hiding the cancel button
    private var textFieldTrailingConstraint: NSLayoutConstraint!
    private var cancelButtonTrailingConstraint: NSLayoutConstraint!
    
    // UITextField pendants
    public var searchBarShouldBeginEditing: (()->(Bool))?
    public var searchBarDidBeginEditing: (()->())?
    public var searchBarShouldEndEditing: (()->(Bool))?
    public var searchBarDidEndEditing: (()->())?
    public var searchBarShouldChangeCharactersInRange: ((range: NSRange, replacementString: String)->(Bool))?
    public var searchBarShouldClear: (()->(Bool))?
    public var searchBarShouldReturn: (()->(Bool))?
    
    // Cancel Button handler
    public var searchBarPressedCancel: (()->())?
    
    // Customizing the text field
    public var autocorrectionType: UITextAutocorrectionType {
        willSet { textField.autocorrectionType = newValue }
    }
    public var autocapitalizationType: UITextAutocapitalizationType {
        willSet { textField.autocapitalizationType = newValue }
    }
    public var spellCheckingType: UITextSpellCheckingType {
        willSet { textField.spellCheckingType = newValue }
    }
    public var leftViewMode: UITextFieldViewMode {
        willSet { textField.leftViewMode = newValue }
    }
    public var rightViewMode: UITextFieldViewMode {
        willSet { textField.rightViewMode = newValue }
    }
    public var clearButtonMode: UITextFieldViewMode {
        willSet { textField.clearButtonMode = newValue }
    }
    //! This styles the cursor as well as the selection marker
    public var searchbarTintColor: UIColor {
        willSet { textField.tintColor = newValue }
    }
    public var typingAttributes: [String:AnyObject]? {
        willSet { textField.typingAttributes = newValue }
    }
    public var defaultTextAttributes: [String:AnyObject] {
        willSet { textField.defaultTextAttributes = newValue }
    }
    public var attributedPlaceholder: AttributedString? {
        willSet { textField.attributedPlaceholder = newValue }
    }
    
    
    // MARK: - Lifecycle
    public override init(frame: CGRect) {
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        leftViewMode = .always
        rightViewMode = .whileEditing
        clearButtonMode = .whileEditing
        searchbarTintColor = UIColor.black()
        defaultTextAttributes = [NSForegroundColorAttributeName:UIColor.black(), NSBackgroundColorAttributeName: UIColor.clear()]
        typingAttributes = defaultTextAttributes
        super.init(frame: frame)

        textField.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        leftViewMode = .always
        rightViewMode = .whileEditing
        clearButtonMode = .whileEditing
        searchbarTintColor = UIColor.black()
        defaultTextAttributes = [NSForegroundColorAttributeName:UIColor.black(), NSBackgroundColorAttributeName: UIColor.clear()]
        typingAttributes = defaultTextAttributes
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let handler = searchBarShouldBeginEditing else {
            return true
        }
        return handler()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBarDidBeginEditing?()
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let handler = searchBarShouldEndEditing else {
            return true
        }
        return handler()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        searchBarDidEndEditing?()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let handler = searchBarShouldChangeCharactersInRange else {
            return true
        }
        return handler(range: range, replacementString: string)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        guard let handler = searchBarShouldClear else {
            return true
        }
        return handler()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let handler = searchBarShouldReturn else {
            return true
        }
        return handler()
    }
}
