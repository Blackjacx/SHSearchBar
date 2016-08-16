//
//  SHSearchBar.swift
//  Pods
//
//  Created by Stefan Herold on 01/08/16.
//
//

import UIKit

let kDefaultAnimationDuration: NSTimeInterval = 0.25

public class SHSearchBar: UIView, UITextFieldDelegate {
    private(set) var backgroundView: UIImageView = UIImageView()

    public var cancelButton: UIButton = UIButton(type: .Custom)
    public var textField: UITextField = UITextField()

    // Constraints for showing and hiding the cancel button
    private(set) var bgToCancelButtonConstraint: NSLayoutConstraint!
    private(set) var bgToParentConstraint: NSLayoutConstraint!
    
    public var delegate: SHSearchBarDelegate?
    
    
    // MARK: - Lifecycle
    
    public init(with rasterSize: CGFloat) {
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
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: rasterSize, height: 10.0))

        // These are the properties you probably want to customize
        textField.leftViewMode = .Always
        textField.rightViewMode = .Never
        textField.clearButtonMode = .WhileEditing
        textField.tintColor = UIColor.blackColor() // Styles the cursor as well as the selection marker
        textField.defaultTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSBackgroundColorAttributeName: UIColor.clearColor()]
        textField.typingAttributes = textField.defaultTextAttributes

        textField.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(textField)

        // Cancel Button
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

        setupConstraints(with: rasterSize)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints(with rasterSize: CGFloat) {
        let views = ["text":textField, "bg":backgroundView, "cancel":cancelButton]
        let metrics = ["margin":rasterSize]
        
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

        bgToCancelButtonConstraint = NSLayoutConstraint(item: backgroundView, attribute: .Trailing, relatedBy: .Equal, toItem: cancelButton, attribute: .Leading, multiplier: 1, constant: -rasterSize)
        bgToParentConstraint = NSLayoutConstraint(item: backgroundView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0)
        bgToParentConstraint.active = true
    }


    // MARK: - UI Updates

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


    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let result = delegate?.searchBarShouldBeginEditing?(self) {
            if result {
                setCancelButtonVisibility(true)
            }
            return result
        }
        setCancelButtonVisibility(true)
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.searchBarDidBeginEditing?(self)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let result = delegate?.searchBarShouldEndEditing?(self) {
            if result {
                setCancelButtonVisibility(false)
            }
            return result
        }
        setCancelButtonVisibility(false)
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchBarDidEndEditing?(self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.searchBar?(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let result = delegate?.searchBarShouldClear?(self) {
            return result
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let result = delegate?.searchBarShouldReturn?(self) {
            return result
        }
        return true
    }
    
    // MARK: - Cancel Button Management
    
    func pressedCancelButton(sender: AnyObject) {
        textField.resignFirstResponder()
        delegate?.searchBarShouldCancel?(self) ?? true
    }

    private func setCancelButtonVisibility(makeVisible: Bool) {
        // Thsi 'complex' if-else avoids constraint warnings in the console
        if makeVisible {
            bgToParentConstraint.active = false
            bgToCancelButtonConstraint.active = true
        } else {
            bgToCancelButtonConstraint.active = false
            bgToParentConstraint.active = true
        }

        UIView.animateWithDuration(kDefaultAnimationDuration, delay: 0, options: [.CurveEaseInOut], animations: {
            self.layoutIfNeeded()
            self.cancelButton.alpha = makeVisible ? 1 : 0
        }, completion: nil)
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
