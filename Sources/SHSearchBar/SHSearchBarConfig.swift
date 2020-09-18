//
//  SHSearchBarConfig.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 17/08/16.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit

public struct SHSearchBarConfig {
    /// The animation duration for showing/hiding the cancel button.
    public var animationDuration: TimeInterval = 0.25 // good value

    /// The width and height for one square of the layout raster. All sizes,
    /// margins, distances, etc. are calculated as multiples of this value.
    public var rasterSize: CGFloat = 11.0

    /// The attributes to format the searchbars text.
    public var textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: defaultTextForegroundColor]

    /// The textContentType property is to provide the keyboard with extra information about the semantic intent of the text document.
    public var textContentType: String?

    /// Controls the visibility of the cancel button
    public var useCancelButton: Bool = true

    /// The title of the cancel button.
    public var cancelButtonTitle: String = "sb.general.cancel".localized

    /// The text attributes to style the cancel button.
    public var cancelButtonTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: defaultTextForegroundColor]

    /// The left accessory view of the searchbar. For searchbars there is typically a search glass.
    public var leftView: UIView?

    /// The left view mode of the searchbar regarding to a leftView.
    public var leftViewMode: UITextField.ViewMode = .never

    /// The right accessory view of the searchbar. For searchbars there is typically a search glass.
    public var rightView: UIView?

    /// The right view mode of the searchbar regarding to a rightView.
    public var rightViewMode: UITextField.ViewMode = .always

    /// Controls when to show the clear button.
    public var clearButtonMode: UITextField.ViewMode = .whileEditing

    // MARK: - Lifecycle

    /// Use this initializer and then set the properties to your desired values.
    public init() {}

    // MARK: - Defaults

    /// This is used as the default text foreground color for button and text in the searchbar if nothing has been set by the user.
    public static var defaultTextForegroundColor = UIColor.black
}
