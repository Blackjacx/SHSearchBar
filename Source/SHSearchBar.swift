//
//  SHSearchBar.swift
//  Pods
//
//  Created by Stefan Herold on 01/08/16.
//
//

import UIKit

public class SHSearchBar: UIView, UITextFieldDelegate {
    /// The content of this property is used to restore the textField text after cancellation
    var textBeforeEditing: String?

    /// Constraint that shows the cancel button when active
    var bgToCancelButtonConstraint: NSLayoutConstraint!
    /// Constraint that hides the cancel button when active
    var bgToParentConstraint: NSLayoutConstraint!

    public var config: SHSearchBarConfig {
        didSet {
            if let textField = textField as? SHSearchBarTextField  {
                textField.config = config
            }
            updateUI()
            updateAllViewConstraints()
        }
    }

    public var isActive: Bool = true {
        didSet {
            updateUI()
        }
    }

    public let backgroundView: UIImageView = UIImageView()
    public let cancelButton: UIButton = UIButton(type: .custom)
    public let textField: UITextField


    public weak var delegate: SHSearchBarDelegate?

    
    // MARK: - Lifecycle

    public init(config: SHSearchBarConfig) {
        self.config = config
        self.textField = SHSearchBarTextField(config: config)

        super.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false

        setupBackgroundView(config)
        setupTextField(config)
        setupCancelButton(config)

        backgroundView.addSubview(textField)
        addSubview(cancelButton)
        addSubview(backgroundView)

        updateAllViewConstraints()

        updateUI()
    }

    func setupBackgroundView(_ config: SHSearchBarConfig) {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.isUserInteractionEnabled = true
        updateBackgroundWith(0, corners: .allCorners, color: UIColor.white)
    }

    func setupTextField(_ config: SHSearchBarConfig) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.autocorrectionType = .default
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.adjustsFontSizeToFitWidth = false
        textField.clipsToBounds = true

        // These are the properties you probably want to customize
        textField.leftViewMode = .never
        textField.rightViewMode = .never
        textField.clearButtonMode = .whileEditing
    }

    func setupCancelButton(_ config: SHSearchBarConfig) {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.alpha = 0.0
        cancelButton.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        cancelButton.reversesTitleShadowWhenHighlighted = true
        cancelButton.adjustsImageWhenHighlighted = true
        cancelButton.addTarget(self, action: #selector(SHSearchBar.pressedCancelButton(_:)), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateAllViewConstraints() {
        let isInitialUpdate = backgroundView.constraints.isEmpty
        let isTextFieldInEditMode = bgToCancelButtonConstraint?.isActive ?? false

        bgToParentConstraint?.isActive = false
        bgToCancelButtonConstraint?.isActive = false

        if #available(iOS 9.0, *) {
            if isInitialUpdate {
                let constraints = [
                    backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
                    backgroundView.topAnchor.constraint(equalTo: topAnchor),
                    backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

                    textField.leftAnchor.constraint(equalTo: backgroundView.leftAnchor),
                    textField.rightAnchor.constraint(equalTo: backgroundView.rightAnchor),
                    textField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
                    textField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),

                    cancelButton.rightAnchor.constraint(equalTo: rightAnchor),
                    cancelButton.topAnchor.constraint(equalTo: topAnchor),
                    cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                    ]
                NSLayoutConstraint.activate(constraints)

                bgToParentConstraint = backgroundView.rightAnchor.constraint(equalTo: rightAnchor)
                bgToCancelButtonConstraint = backgroundView.rightAnchor.constraint(equalTo: cancelButton.leftAnchor, constant: -config.rasterSize)
            }

        } else {
            if isInitialUpdate {
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
                    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: views))
                }
                bgToParentConstraint = NSLayoutConstraint(item: backgroundView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
                bgToCancelButtonConstraint = NSLayoutConstraint(item: backgroundView, attribute: .trailing, relatedBy: .equal, toItem: cancelButton, attribute: .leading, multiplier: 1, constant: -config.rasterSize)
            }
        }

        bgToCancelButtonConstraint.constant = -config.rasterSize

        if isTextFieldInEditMode && !isInitialUpdate {
            bgToCancelButtonConstraint.isActive = true
        } else {
            bgToParentConstraint.isActive = true
        }
    }


    // MARK: - UI Updates

    func updateUI() {
        var textColor = config.textAttributes[NSForegroundColorAttributeName] as? UIColor ?? SHSearchBarConfig.defaultTextForegroundColor

        // Replace normal color with a lighter color so the text looks disabled
        if !isActive { textColor = textColor.withAlphaComponent(0.5) }

        textField.tintColor = textColor // set cursor color
        textField.textColor = textColor
        textField.leftView = config.leftView
        textField.rightView = config.rightView

        var textAttributes:[String:Any] = config.textAttributes
        textAttributes[NSForegroundColorAttributeName] = textColor
        textField.defaultTextAttributes = textAttributes

        cancelButton.setTitle(config.cancelButtonTitle , for: UIControlState())
        cancelButton.setTitleColor(config.cancelButtonTextColor, for: UIControlState())
        cancelButton.setTitleColor(config.cancelButtonTextColor.withAlphaComponent(0.75), for: .highlighted)

        if #available(iOS 10.0, *) {
            if let textContentType = config.textContentType {
                textField.textContentType = UITextContentType(rawValue: textContentType)
            }
        }
    }

    /*
     * Use this function to specify the views corner radii. 
     * It will be applied to a special background image view (not the search bar itself) that spans the whole search bar. 
     * The backgroundColor of this view must remain clear to make the corner radius visible.
     */
    //!
    public func updateBackgroundWith(_ radius: CGFloat, corners: UIRectCorner, color: UIColor) {
        let insets = UIEdgeInsets(top: radius, left: radius, bottom: radius, right: radius)
        let imgSize = CGSize(width: radius*2 + 1, height: radius*2 + 1)
        var img = UIImage.imageWithSolidColor(color, size: imgSize)
        img = img.roundedImage(with: radius, cornersToRound: corners)
        img = img.resizableImage(withCapInsets: insets)
        backgroundView.image = img
        backgroundColor = UIColor.clear
    }

    /**
     * Resets the textFields content to the value when etiting has been started. This function is called when the cancel button has been pressed.
     */
    func resetTextField() {
        let oldText = textField.text
        textField.text = textBeforeEditing
        if oldText != textField.text {
            delegate?.searchBar?(self, textDidChange: "")
        }
    }


    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let shouldBegin = delegate?.searchBarShouldBeginEditing?(self) ?? true
        if shouldBegin {
            setCancelButtonVisibility(true)
        }
        return shouldBegin
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textBeforeEditing = textField.text
        delegate?.searchBarDidBeginEditing?(self)
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let shouldEnd = delegate?.searchBarShouldEndEditing?(self) ?? true
        if shouldEnd {
            setCancelButtonVisibility(false)
        }
        return shouldEnd
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchBarDidEndEditing?(self)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let shouldChange = delegate?.searchBar?(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
        if shouldChange {
            let currentText = NSString(string: textField.text ?? "")
            let newText: String = currentText.replacingCharacters(in: range, with: string)
            if !currentText.isEqual(to: newText) {
                delegate?.searchBar?(self, textDidChange: newText)
            }
        }
        return shouldChange
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let shouldClear = delegate?.searchBarShouldClear?(self) ?? true
        return shouldClear
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let shouldReturn = delegate?.searchBarShouldReturn?(self) ?? true
        return shouldReturn
    }

    
    // MARK: - Cancel Button Management
    
    func pressedCancelButton(_ sender: AnyObject) {
        if delegate?.searchBarShouldCancel == nil || (delegate?.searchBarShouldCancel?(self))! == true {
            resetTextField()
            textField.resignFirstResponder()
        }
    }

    func setCancelButtonVisibility(_ makeVisible: Bool) {
        // This 'complex' if-else avoids constraint warnings in the console
        if makeVisible {
            bgToParentConstraint.isActive = false
            bgToCancelButtonConstraint.isActive = true
        } else {
            bgToCancelButtonConstraint.isActive = false
            bgToParentConstraint.isActive = true
        }

        UIView.animate(withDuration: config.animationDuration, delay: 0, options: UIViewAnimationOptions(), animations: {
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
