//
//  Foundation + Extensions.swift
//  Nimble
//
//  Created by Stefan Herold on 16.02.18.
//

import Foundation

extension String {

    private class AFrameworkClass {}

    var localized: String {
        let appTranslation = NSLocalizedString(self, comment: "")

        if appTranslation != self {
            return appTranslation
        }

        let frameworkBundle = Bundle(for: AFrameworkClass.self)
        guard let resourceBundlePath = frameworkBundle.path(forResource: "SHSearchBar", ofType: "bundle") else { return self }
        guard let resourceBundle = Bundle(path: resourceBundlePath) else { return self }

        let frameworkTranslation = NSLocalizedString(self, tableName: "Localizable", bundle: resourceBundle, value: self, comment: "")

        if frameworkTranslation != self {
            return frameworkTranslation
        }

        return self
    }
}
