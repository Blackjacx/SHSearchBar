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

    public let config: SHSearchBarConfig
    public let backgroundView: UIImageView = UIImageView()
    public let cancelButton: UIButton = UIButton(type: .Custom)
    public let textField: UITextField = UITextField()

    public var isActive: Bool = true { didSet { updateUI() } }
    public weak var delegate: SHSearchBarDelegate?

    
    // MARK: - Lifecycle

    public init(config: SHSearchBarConfig) {
        self.config = config
        
        super.init(frame: CGRectZero)
        
        translatesAutoresizingMaskIntoConstraints = false

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.userInteractionEnabled = true
        updateBackgroundWith(0, corners: .AllCorners, color: UIColor.whiteColor())
        addSubview(backgroundView)

        // Text Field
        textField.delegate = self
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .None
        textField.spellCheckingType = .No
        textField.adjustsFontSizeToFitWidth = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: config.rasterSize, height: 10.0))

        // These are the properties you probably want to customize
        textField.leftViewMode = .Always
        textField.rightViewMode = .Never
        textField.clearButtonMode = .WhileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(textField)

        // Cancel Button
        cancelButton.alpha = 0.0
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: "") , forState: .Normal)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cancelButton.setTitleColor(UIColor.darkGrayColor(), forState: .Highlighted)
        cancelButton.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        cancelButton.reversesTitleShadowWhenHighlighted = true
        cancelButton.adjustsImageWhenHighlighted = true
        cancelButton.addTarget(self, action: #selector(SHSearchBar.pressedCancelButton(_:)), forControlEvents: .TouchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        sendSubviewToBack(cancelButton)

        setupConstraints()
        updateUI()
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
        var newAttributes = config.textAttributes
        var normalTextColor = newAttributes[NSForegroundColorAttributeName] as? UIColor

        // Replace normal color with a lighter color so the text looks disabled
        if !isActive {
            normalTextColor = normalTextColor?.colorWithAlphaComponent(0.5)
            newAttributes[NSForegroundColorAttributeName] = normalTextColor
        }

        // Set the cursor color
        textField.tintColor = normalTextColor

        textField.defaultTextAttributes = newAttributes
        textField.textColor = normalTextColor
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
        textField.text = textBeforeEditing
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
        // Thsi 'complex' if-else avoids constraint warnings in the console
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
