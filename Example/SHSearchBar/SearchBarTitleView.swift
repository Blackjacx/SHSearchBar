//
//  SearchBarTitleView.swift
//  iOS Example
//
//  Created by Stefan Herold on 20.12.17.
//  Copyright © 2017 StefanHerold. All rights reserved.
//

import UIKit
import SHSearchBar

class SearchbarTitleView: UIView {

    private let searchbar: SHSearchBar

    init(searchbar: SHSearchBar) {

        self.searchbar = searchbar
        super.init(frame: .zero)

        addSubview(self.searchbar)
        setupLayoutConstraints()
    }

    @available(*, unavailable, message:"init(coder:) has not been implemented")
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func setupLayoutConstraints() {

        let constraints = [
            searchbar.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            searchbar.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            searchbar.topAnchor.constraint(equalTo: topAnchor),
            searchbar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // This is important to make the title view expanding from left to right
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}

