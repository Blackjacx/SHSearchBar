//
//  SHSearchBar.swift
//  Pods
//
//  Created by Stefan Herold on 01/08/16.
//
//

import UIKit

public class SHSearchBar: UIView, UITextFieldDelegate {
    private var textBeforeEditing: String?

    // Constraints for showing and hiding the cancel button
    private(set) var bgToCancelButtonConstraint: NSLayoutConstraint!
    private(set) var bgToParentConstraint: NSLayoutConstraint!

    public var config: SHSearchBarConfig {
        didSet {
            if let textField = textField as? SHSearchBarTextField  {
                textField.config = config
            }
            updateUI()
        }
    }

    public let backgroundView: UIImageView = UIImageView()
    public let cancelButton: UIButton = UIButton(type: .Custom)
    public let textField: UITextField

    public var isActive: Bool = true { didSet { updateUI() } }
    public weak var delegate: SHSearchBarDelegate?


    // MARK: - Text Field Specific

    public var leftView: UIView? {
        get { return textField.leftView }
        set { textField.leftView = leftView }
    }
    public var rightView: UIView? {
        get { return textField.rightView }
        set { textField.rightView = rightView }
    }

    
    // MARK: - Lifecycle

    public init(config: SHSearchBarConfig) {
        self.config = config
        self.textField = SHSearchBarTextField(config: config)

        super.init(frame: CGRectZero)
        
        translatesAutoresizingMaskIntoConstraints = false

        setupBackgroundView(config)
        setupTextField(config)
        setupCancelButton(config)

        backgroundView.addSubview(textField)
        addSubview(cancelButton)
        addSubview(backgroundView)

        setupConstraints()

        updateUI()
    }

    private func setupBackgroundView(config: SHSearchBarConfig) {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.userInteractionEnabled = true
        updateBackgroundWith(0, corners: .AllCorners, color: UIColor.whiteColor())
    }

    private func setupTextField(config: SHSearchBarConfig) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.autocorrectionType = .Default
        textField.autocapitalizationType = .None
        textField.spellCheckingType = .No
        textField.adjustsFontSizeToFitWidth = false

        // These are the properties you probably want to customize
        textField.leftViewMode = .Never
        textField.rightViewMode = .Never
        textField.clearButtonMode = .WhileEditing
    }

    private func setupCancelButton(config: SHSearchBarConfig) {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.alpha = 0.0
        cancelButton.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        cancelButton.reversesTitleShadowWhenHighlighted = true
        cancelButton.adjustsImageWhenHighlighted = true
        cancelButton.addTarget(self, action: #selector(SHSearchBar.pressedCancelButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        let views = ["text":textField, "bg":backgroundView, "cancel":cancelButton]
        let metrics = ["margin":config.rasterSize]
        
        let formatList: [String] = [
            // Background
            "H:|[bg]",
            "V:|[bg]|",
            // Text field
            "H:|[text]|",
            "V:|[text]|",
            // Cancel Button
            "H:[cancel]|",
            "V:|[cancel]|"
            ]

        for format in formatList {
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: [], metrics: metrics, views: views))
        }

        bgToCancelButtonConstraint = NSLayoutConstraint(item: backgroundView, attribute: .Trailing, relatedBy: .Equal, toItem: cancelButton, attribute: .Leading, multiplier: 1, constant: -config.rasterSize)
        bgToParentConstraint = NSLayoutConstraint(item: backgroundView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0)
        bgToParentConstraint.active = true
    }


    // MARK: - UI Updates

    func updateUI() {
        var normalTextColor = config.textColor

        // Replace normal color with a lighter color so the text looks disabled
        if !isActive {
            normalTextColor = normalTextColor.colorWithAlphaComponent(0.5)
        }

        // Set the cursor color
        textField.tintColor = normalTextColor

        textField.defaultTextAttributes = [NSForegroundColorAttributeName:normalTextColor, NSBackgroundColorAttributeName: config.textBackgroundColor]
        textField.textColor = normalTextColor

        cancelButton.setTitle(config.cancelButtonTitle , forState: .Normal)
        cancelButton.setTitleColor(config.cancelButtonTextColor, forState: .Normal)
        cancelButton.setTitleColor(config.cancelButtonTextColor.colorWithAlphaComponent(0.75), forState: .Highlighted)

        if #available(iOS 10.0, *) {
            if let textContentType = config.textContentType {
                textField.textContentType = textContentType
            }
        }
    }

    //! Use this function to specify the views corner radii. It will be applied to a special background image view (not the search bar itself) that spans the whole search bar. The backgroundColor of this view must remain clear to make the corner radius visible.
    public func updateBackgroundWith(radius: CGFloat, corners: UIRectCorner, color: UIColor) {
        let insets = UIEdgeInsets(top: radius, left: radius, bottom: radius, right: radius)
        let imgSize = CGSize(width: radius*2 + 1, height: radius*2 + 1)
        var img = UIImage.imageWithSolidColor(color, size: imgSize)
        img = img.roundedImage(with: radius, cornersToRound: corners)
        img = img.resizableImageWithCapInsets(insets)
        backgroundView.image = img
        backgroundColor = UIColor.clearColor()
    }

    public func resetTextField() {
        let oldText = textField.text
        textField.text = textBeforeEditing
        if oldText != textField.text {
            delegate?.searchBar?(self, textDidChange: "")
        }
    }


    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let shouldBegin = delegate?.searchBarShouldBeginEditing?(self) ?? true
        if shouldBegin {
            setCancelButtonVisibility(true)
        }
        return shouldBegin
    }
    
    public func textFieldDidBeginEditing(textField: UITextField) {
        textBeforeEditing = textField.text
        delegate?.searchBarDidBeginEditing?(self)
    }
    
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        let shouldEnd = delegate?.searchBarShouldEndEditing?(self) ?? true
        if shouldEnd {
            setCancelButtonVisibility(false)
        }
        return shouldEnd
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        delegate?.searchBarDidEndEditing?(self)
    }

    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let shouldChange = delegate?.searchBar?(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
        if shouldChange {
            let currentText = NSString(string: textField.text ?? "")
            let newText: String = currentText.stringByReplacingCharactersInRange(range, withString: string)
            if !currentText.isEqualToString(newText) {
                delegate?.searchBar?(self, textDidChange: newText)
            }
        }
        return shouldChange
    }
    
    public func textFieldShouldClear(textField: UITextField) -> Bool {
        let shouldClear = delegate?.searchBarShouldClear?(self) ?? true
        return shouldClear
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        let shouldReturn = delegate?.searchBarShouldReturn?(self) ?? true
        return shouldReturn
    }

    
    // MARK: - Cancel Button Management
    
    func pressedCancelButton(sender: AnyObject) {
        textField.resignFirstResponder()
        delegate?.searchBarShouldCancel?(self)
    }

    func setCancelButtonVisibility(makeVisible: Bool) {
        // This 'complex' if-else avoids constraint warnings in the console
        if makeVisible {
            bgToParentConstraint.active = false
            bgToCancelButtonConstraint.active = true
        } else {
            bgToCancelButtonConstraint.active = false
            bgToParentConstraint.active = true
        }

        UIView.animateWithDuration(config.animationDuration, delay: 0, options: [.CurveEaseInOut], animations: {
            self.layoutIfNeeded()
            self.cancelButton.alpha = makeVisible ? 1 : 0
        }, completion: nil)
    }
}



@objc
public protocol SHSearchBarDelegate : NSObjectProtocol {
    // UITextField Pendants
    @objc optional func searchBarShouldBeginEditing(searchBar: SHSearchBar) -> Bool // return NO to disallow editing.
    @objc optional func searchBarDidBeginEditing(searchBar: SHSearchBar) // became first responder
    @objc optional func searchBarShouldEndEditing(searchBar: SHSearchBar) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    @objc optional func searchBarDidEndEditing(searchBar: SHSearchBar) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    @objc optional func searchBar(searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    @objc optional func searchBarShouldClear(searchBar: SHSearchBar) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
    @objc optional func searchBarShouldReturn(searchBar: SHSearchBar) -> Bool // called when 'return' key pressed. return NO to ignore.
    
    // New delegate methods
    @objc optional func searchBarShouldCancel(searchBar: SHSearchBar) -> Bool // called when 'cancel' button pressed.
    @objc optional func searchBar(searchBar: SHSearchBar, textDidChange text: String) // Called when the text did change
}
