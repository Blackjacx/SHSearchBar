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

    public init(animationDuration: NSTimeInterval, rasterSize: CGFloat) {
        self.animationDuration = animationDuration
        self.rasterSize = rasterSize
    }
}
