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

    public init(animationDuration: NSTimeInterval, rasterSize: CGFloat, textAttributes: [String: AnyObject]) {
        self.animationDuration = animationDuration
        self.rasterSize = rasterSize
        self.textAttributes = textAttributes
    }
}
