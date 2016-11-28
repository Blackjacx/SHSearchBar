//
//  SHSearchBarTextField.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 27/11/2016.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import UIKit

class SHSearchBarTextField: UITextField {

    var config: SHSearchBarConfig {
        didSet {
            setNeedsLayout()
        }
    }

    init(config: SHSearchBarConfig) {
        self.config = config
        super.init(frame: CGRectZero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Overrides

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        let rect = super.textRectForBounds(bounds)
        return rectForBounds(rect, originalBounds: bounds)
    }

    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        let rect = super.editingRectForBounds(bounds)
        return rectForBounds(rect, originalBounds: bounds)
    }

    private func rectForBounds(bounds: CGRect, originalBounds: CGRect) -> CGRect {
        var minX: CGFloat = 0
        var width: CGFloat = 0

        if bounds.width == originalBounds.width {
            // no left and no right view
            minX = config.rasterSize
            width = bounds.width - config.rasterSize * 2
            
        } else if bounds.minX > 0 && bounds.width == originalBounds.width - bounds.minX {
            // only left view
            minX = bounds.minX
            width = bounds.width - config.rasterSize

        } else if bounds.minX == 0 && bounds.width < originalBounds.width {
            // only right view
            minX = config.rasterSize
            width = bounds.width - config.rasterSize

        } else {
            // left & right view
            minX = bounds.minX
            width = bounds.width
        }
        return CGRect(x: minX, y: 0.0, width: width, height: bounds.height)
    }
}
