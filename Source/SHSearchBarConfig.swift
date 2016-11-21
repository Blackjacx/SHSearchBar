//
//  SHSearchBarConfig.swift
//  Pods
//
//  Created by Stefan Herold on 17/08/16.
//
//

import Foundation

public struct SHSearchBarConfig {
    public let animationDuration: NSTimeInterval
    public let rasterSize: CGFloat
    public let textAttributes: [String: AnyObject]
    public let textContentType: String?
    public let cancelButtonTitle: String
    public let cancelButtonTextColor: UIColor

    public init(animationDuration: NSTimeInterval,
                rasterSize: CGFloat,
                textAttributes: [String: AnyObject],
                cancelButtonTitle: String,
                cancelButtonTextColor: UIColor,
                textContentType: String? = nil) {

        self.animationDuration = animationDuration
        self.rasterSize = rasterSize
        self.textAttributes = textAttributes
        self.textContentType = textContentType
        self.cancelButtonTitle = cancelButtonTitle
        self.cancelButtonTextColor = cancelButtonTextColor
    }
}
