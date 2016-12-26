//
//  SHSearchBarConfig.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 17/08/16.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import UIKit

public struct SHSearchBarConfig {
    /// The animation duration for showing/hiding the cancel button.
    public var animationDuration: TimeInterval = 0.25 // good value

    /// The width and height for one square of the layout raster. All sizes, margins, distances, etc. are calculated as multiples of this value.
    public var rasterSize: CGFloat = 11.0 // Apples default

    /// The attributes to format the searchbars text.
    public var textAttributes: [String:Any] = [NSForegroundColorAttributeName:defaultTextForegroundColor]

    /// The textContentType property is to provide the keyboard with extra information about the semantic intent of the text document.
    public var textContentType: String? = nil

    /// The title of the cancel button.
    public var cancelButtonTitle: String = NSLocalizedString("Cancel", comment: "")

    /// The text attributes to style the cancel button.
    public var cancelButtonTextAttributes: [String:Any] = [NSForegroundColorAttributeName:defaultTextForegroundColor]

    /// The left accessory view of the searchbar. For searchbars there is typically a search glass.
    public var leftView: UIView?

    /// The right accessory view of the searchbar. For searchbars there is typically a search glass.
    public var rightView: UIView?

    // MARK: - Lifecycle

    /// Use this initializer and then set the properties to your desired values.
    public init() {}

    // MARK: - Defaults

    /// This is used as the default text foreground color for button and text in the searchbar if nothing has been set by the user.
    public static var defaultTextForegroundColor = UIColor.black
}

