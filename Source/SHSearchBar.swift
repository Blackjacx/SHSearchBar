//
//  SHSearchBar.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 01/08/16.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import UIKit

/**
 * The central searchbar class of this framework. 
 * You must initialize this class using an instance of SHSearchBarConfig which is also changable later.
 */
public class SHSearchBar: UIView, UITextFieldDelegate, SHSearchBarDelegate {
    /// The content of this property is used to restore the textField text after cancellation
    var textBeforeEditing: String?

    /// Constraint that shows the cancel button when active
    var bgToCancelButtonConstraint: NSLayoutConstraint!
    /// Constraint that hides the cancel button when active
    var bgToParentConstraint: NSLayoutConstraint!

    /// The background image view which is responsible for displaying the rounded corners.
    let backgroundView: UIImageView = UIImageView()

    /// The cancel button under the right side of the searhcbar.
    let cancelButton: UIButton = UIButton(type: .custom)


    // MARK: - Public Properties

    /// This textfield is currently the central element of the searchbar. 
    /// In future it could be possible that this view is exchanged by something different. 
    /// Thats why it is discouraged to access the textfield directly which is the reason why it is declared as internal. 
    let textField: UITextField

    /// The central SHSearchBarConfig instance which configures all searchbar parameters.
    public var config: SHSearchBarConfig {
        didSet {
            if let textField = textField as? SHSearchBarTextField  {
                textField.config = config
            }
            updateUserInterface()
            updateViewConstraints()
        }
    }

    /// You can set the searchbar as inactive with this property. Currently this only dims the text color slightly.
    public var isActive: Bool = true {
        didSet {
            updateUserInterface()
        }
    }

    /// The text of the searchbar. Defaults to nil.
    public var text: String? {set {textField.text = newValue} get {return textField.text}}
    /// The placeholder of the searchbar. Defaults to nil.
    public var placeholder: String? {set {textField.placeholder = newValue} get {return textField.placeholder}}
    /// The text alignment of the searchbar.
    public var textAlignment: NSTextAlignment {set {textField.textAlignment = newValue} get {return textField.textAlignment}}
    /// The left view mode of the searchbar regarding to a leftView (see SHSearchBarConfig).
    public var leftViewMode: UITextFieldViewMode {set {textField.leftViewMode = newValue} get {return textField.leftViewMode}}
    /// The right view mode of the searchbar regarding to a rightView (see SHSearchBarConfig).
    public var rightViewMode: UITextFieldViewMode {set {textField.rightViewMode = newValue} get {return textField.rightViewMode}}

    /// The delegate which informs the user about important events.
    public weak var delegate: SHSearchBarDelegate?

    
    // MARK: - Lifecycle

    /**
     * The designated initializer to initialize the searchbar.
     * - parameter config: The initial SHSearchBarConfig object.
     */
    public init(config: SHSearchBarConfig) {
        self.config = config
        self.textField = SHSearchBarTextField(config: config)

        super.init(frame: CGRect.zero)

        self.delegate = self
        translatesAutoresizingMaskIntoConstraints = false

        setupBackgroundView(withConfig: config)
        setupTextField(withConfig: config)
        setupCancelButton(withConfig: config)

        backgroundView.addSubview(textField)
        addSubview(cancelButton)
        addSubview(backgroundView)

        updateViewConstraints()

        updateUserInterface()
    }

    func setupBackgroundView(withConfig config: SHSearchBarConfig) {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.isUserInteractionEnabled = true
        updateBackgroundImage(withRadius: 0, corners: .allCorners, color: UIColor.white)
    }

    func setupTextField(withConfig config: SHSearchBarConfig) {
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

    func setupCancelButton(withConfig config: SHSearchBarConfig) {
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

    func updateViewConstraints() {
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


    // MARK: - First Responder Handling

    public override var isFirstResponder: Bool {
        return textField.isFirstResponder
    }

    public override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }

    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    public override var canResignFirstResponder: Bool {
        return textField.canResignFirstResponder
    }

    public override var canBecomeFirstResponder: Bool {
        return textField.canBecomeFirstResponder
    }


    // MARK: - UI Updates

    func updateUserInterface() {
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

        let normalAttributes = config.cancelButtonTextAttributes
        cancelButton.setAttributedTitle(NSAttributedString(string: config.cancelButtonTitle, attributes: normalAttributes), for: .normal)
        var highlightedAttributes = config.cancelButtonTextAttributes
        let highlightColor = highlightedAttributes[NSForegroundColorAttributeName] as? UIColor ?? SHSearchBarConfig.defaultTextForegroundColor
        highlightedAttributes[NSForegroundColorAttributeName] = highlightColor.withAlphaComponent(0.75)
        cancelButton.setAttributedTitle(NSAttributedString(string: config.cancelButtonTitle, attributes: highlightedAttributes), for: .highlighted)

        if #available(iOS 10.0, *) {
            if let textContentType = config.textContentType {
                textField.textContentType = UITextContentType(rawValue: textContentType)
            }
        }
    }

    /**
     * Use this function to specify the views corner radii. They will be applied to the background
     * image view that spans the whole search bar. The backgroundColor of this view must remain clear to 
     * make the corner radius visible.
     * - parameter withRadius: The radius in pt to apply to the given corners.
     * - parameter corners: The corners to apply the radius to.
     * - parameter color: The solid color of the background image.
     */
    public func updateBackgroundImage(withRadius radius: CGFloat, corners: UIRectCorner, color: UIColor) {
        let insets = UIEdgeInsets(top: radius, left: radius, bottom: radius, right: radius)
        let imgSize = CGSize(width: radius*2 + 1, height: radius*2 + 1)
        var img = UIImage.imageWithSolidColor(color, size: imgSize)
        img = img.roundedImage(with: radius, cornersToRound: corners)
        img = img.resizableImage(withCapInsets: insets)
        backgroundView.image = img
        backgroundColor = UIColor.clear
    }

    /**
     * Resets the textFields content to the value when etiting has been started. 
     * This function is called when the cancel button has been pressed.
     */
    func resetTextField() {
        let oldText = textField.text
        textField.text = textBeforeEditing
        if oldText != textField.text {
            delegate?.searchBar(self, textDidChange: "")
        }
    }


    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let shouldBegin = delegate?.searchBarShouldBeginEditing(self) ?? searchBarShouldBeginEditing(self)
        if shouldBegin {
            updateCancelButtonVisibility(makeVisible: true)
        }
        return shouldBegin
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textBeforeEditing = textField.text
        delegate?.searchBarDidBeginEditing(self)
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let shouldEnd = delegate?.searchBarShouldEndEditing(self) ?? searchBarShouldEndEditing(self)
        if shouldEnd {
            updateCancelButtonVisibility(makeVisible: false)
        }
        return shouldEnd
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchBarDidEndEditing(self)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let shouldChange = delegate?.searchBar(self, shouldChangeCharactersIn: range, replacementString: string) ?? searchBar(self, shouldChangeCharactersIn: range, replacementString: string)
        if shouldChange {
            let currentText = NSString(string: textField.text ?? "")
            let newText: String = currentText.replacingCharacters(in: range, with: string)
            if !currentText.isEqual(to: newText) {
                delegate?.searchBar(self, textDidChange: newText)
            }
        }
        return shouldChange
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let shouldClear = delegate?.searchBarShouldClear(self) ?? searchBarShouldClear(self)
        return shouldClear
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let shouldReturn = delegate?.searchBarShouldReturn(self) ?? searchBarShouldReturn(self)
        return shouldReturn
    }

    
    // MARK: - Cancel Button Management
    
    func pressedCancelButton(_ sender: AnyObject) {
        let shouldCancel = delegate?.searchBarShouldCancel(self) ?? searchBarShouldCancel(self)
        if shouldCancel {
            resetTextField()
            textField.resignFirstResponder()
        }
    }

    func updateCancelButtonVisibility(makeVisible show: Bool) {
        // This 'complex' if-else avoids constraint warnings in the console
        if show {
            bgToParentConstraint.isActive = false
            bgToCancelButtonConstraint.isActive = true
        } else {
            bgToCancelButtonConstraint.isActive = false
            bgToParentConstraint.isActive = true
        }

        UIView.animate(withDuration: config.animationDuration, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.layoutIfNeeded()
            self.cancelButton.alpha = show ? 1 : 0
        }, completion: nil)
    }
}


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
