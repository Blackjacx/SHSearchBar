//
//  Foundation + Extensions.swift
//  Nimble
//
//  Created by Stefan Herold on 16.02.18.
//

import Foundation

extension String {

    var localized: String {
        let frameworkTranslation = NSLocalizedString(self, tableName: "Localizable", bundle: .module, value: self, comment: "")

        return if frameworkTranslation != self {
            frameworkTranslation
        } else {
            self
        }
    }
}
