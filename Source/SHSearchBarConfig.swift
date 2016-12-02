//
//  SHSearchBarConfig.swift
//  Pods
//
//  Created by Stefan Herold on 17/08/16.
//
//

import Foundation

public struct SHSearchBarConfig {
    public var animationDuration: TimeInterval = 0.25 // good value

    public var rasterSize: CGFloat = 11.0 // Apples default

    public var textColor: UIColor = UIColor.black

    public var textBackgroundColor: UIColor = UIColor.clear

    public var textContentType: String? = nil

    public var cancelButtonTitle: String = NSLocalizedString("Cancel", comment: "")

    public var cancelButtonTextColor: UIColor = UIColor.white

    public init() {}
}

