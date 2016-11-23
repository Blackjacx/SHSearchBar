//
//  SHSearchBarConfig.swift
//  Pods
//
//  Created by Stefan Herold on 17/08/16.
//
//

import Foundation

public struct SHSearchBarConfig {
    public var animationDuration: NSTimeInterval = 0.25 // good value

    public var rasterSize: CGFloat = 11.0 // Apples default

    public var textColor: UIColor = UIColor.blackColor()

    public var textBackgroundColor: UIColor = UIColor.clearColor()

    public var textContentType: String?

    public var cancelButtonTitle: String = NSLocalizedString("Cancel", comment: "")

    public var cancelButtonTextColor: UIColor = UIColor.whiteColor()

    public init() {}

    public init(animationDuration: NSTimeInterval,
                rasterSize: CGFloat,
                textColor: UIColor,
                textBackgroundColor: UIColor,
                cancelButtonTitle: String,
                cancelButtonTextColor: UIColor,
                textContentType: String? = nil) {

        self.animationDuration = animationDuration
        self.rasterSize = rasterSize
        self.textColor = textColor
        self.textBackgroundColor = textBackgroundColor
        self.textContentType = textContentType
        self.cancelButtonTitle = cancelButtonTitle
        self.cancelButtonTextColor = cancelButtonTextColor
    }
}

