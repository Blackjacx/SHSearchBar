//
//  SHSearchBar.swift
//  Pods
//
//  Created by Stefan Herold on 01/08/16.
//
//

import UIKit

public class SHSearchBar: UIView, UITextFieldDelegate {
    private var backgroundView: UIView = UIView()
    private var cancelButton: UIButton = UIButton(type: .custom)
    private var textField: UITextField = UITextField()
    
    // Constraints for showing and hiding the cancel button
    private var textFieldTrailingConstraint: NSLayoutConstraint!
    private var cancelButtonTrailingConstraint: NSLayoutConstraint!
    
    public var delegate: SHSearchBarDelegate?
    
    
    // MARK: - Text Field Properties
    
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
    public var text: String? {
        willSet { textField.text = newValue }
    }
    
    
    // MARK: - Overwritten Properties
    
    //! Use this property to set the background color. It will be applied to a special background (not the search bar itself) view that spans the whole search bar.
    public override var backgroundColor: UIColor? {
        get { return backgroundView.backgroundColor }
        set { backgroundView.backgroundColor = newValue }
    }
    
    
    // MARK: - Custom Properties
    
    //! Use this property to specify the views corner radius. It will be applied to a special background view (not the search bar itself) that spans the whole search bar. The backgroundColor of this view must remain clear to make the corner radius visible.
    public var cornerRadius: CGFloat {
        get { return backgroundView.layer.cornerRadius }
        set {
            backgroundView.layer.cornerRadius = newValue
            backgroundView.layer.masksToBounds = true
        }
    }
    
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        leftViewMode = .always
        rightViewMode = .unlessEditing
        clearButtonMode = .whileEditing
        searchbarTintColor = UIColor.black()
        defaultTextAttributes = [NSForegroundColorAttributeName:UIColor.black(), NSBackgroundColorAttributeName: UIColor.clear()]
        typingAttributes = defaultTextAttributes
        super.init(frame: frame)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        
        setupConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        let views = ["text_field":textField, "background":backgroundView]
        let metrics = ["margin":11, "buttonHeight":44]
        
        let formatList: [String] = [
            // Background
            "H:|[background]|",
            "V:|[background]|",
            // Text field
            "H:|-(margin)-[text_field]-(margin)-|",
            "V:|-(margin)-[text_field]-(margin)-|",
            ]
        
        for format in formatList {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: views))
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let result = delegate?.searchBarShouldBeginEditing?(self) where result {
            showCancelButton()
        }
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.searchBarDidBeginEditing?(self)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let result = delegate?.searchBarShouldEndEditing?(self) where result {
            hideCancelButton()
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchBarDidEndEditing?(self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.searchBar?(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.searchBarShouldClear?(self) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.searchBarShouldReturn?(self) ?? true
    }
    
    // MARK: - Cancel Button Management
    
    @objc private func pressedCancelButton(sender: AnyObject) {
        delegate?.searchBarShouldCancel?(self) ?? true
    }
    
    private func showCancelButton() {
        
    }
    
    private func hideCancelButton() {
        
    }
}



@objc
public protocol SHSearchBarDelegate : NSObjectProtocol {
    // UITextField Pendants
    @objc optional func searchBarShouldBeginEditing(_ searchBar: SHSearchBar) -> Bool // return NO to disallow editing.
    @objc optional func searchBarDidBeginEditing(_ searchBar: SHSearchBar) // became first responder
    @objc optional func searchBarShouldEndEditing(_ searchBar: SHSearchBar) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    @objc optional func searchBarDidEndEditing(_ searchBar: SHSearchBar) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    @objc optional func searchBar(_ searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    @objc optional func searchBarShouldClear(_ searchBar: SHSearchBar) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
    @objc optional func searchBarShouldReturn(_ searchBar: SHSearchBar) -> Bool // called when 'return' key pressed. return NO to ignore.
    
    // New delegate methods
    @objc optional func searchBarShouldCancel(_ searchBar: SHSearchBar) -> Bool // called when 'cancel' button pressed.
    @objc optional func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) // Called when the text did change
}
