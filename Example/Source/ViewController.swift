//
//  ViewController.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 08/01/2016.
//  Copyright (c) 2016 Stefan Herold. All rights reserved.
//

import UIKit
import AddressBookUI
import Contacts
import SHSearchBar

class ViewController: UIViewController, SHSearchBarDelegate {

    var rasterSize: CGFloat = 11.0

    var searchBar1: SHSearchBar!
    var searchBar2: SHSearchBar!
    var searchBar3: SHSearchBar!
    var searchBar4: SHSearchBar!
    var noCancelButtonSearchbar: SHSearchBar!
    var addressSearchbarTop: SHSearchBar!
    var addressSearchbarBottom: SHSearchBar!
    var navigationSearchBar: SHSearchBar!

    var viewConstraints: [NSLayoutConstraint]?

    let addressFormatter: CNPostalAddressFormatter = {
        let formatter = CNPostalAddressFormatter()
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchGlassIconTemplate = UIImage(named: "icon-search")!.withRenderingMode(.alwaysTemplate)

        view.backgroundColor = UIColor.white

        // Hides the line of the bottom of the navigation bar
        navigationController?.navigationBar.shadowImage = UIImage()

        let leftView1 = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar1 = defaultSearchBar(withRasterSize: rasterSize, leftView: leftView1, rightView: nil, delegate: self)
        view.addSubview(searchBar1)

        let rightView2 = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar2 = defaultSearchBar(withRasterSize: rasterSize, leftView: nil, rightView: rightView2, delegate: self)
        searchBar2.text = NSLocalizedString("sbe.exampleText.simple", comment: "")
        view.addSubview(searchBar2)

        let leftView3 = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        let rightView3 = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar3 = defaultSearchBar(withRasterSize: rasterSize, leftView: leftView3, rightView: rightView3, delegate: self)
        searchBar3.text = NSLocalizedString("sbe.exampleText.withLeftView", comment: "")
        view.addSubview(searchBar3)

        // TODO: SearchBar4: centered text lets the icon on the left - this is not intended!
        let leftView4 = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar4 = defaultSearchBar(withRasterSize: rasterSize, leftView: leftView4, rightView: nil, delegate: self)
        searchBar4.textAlignment = .center
        searchBar4.text = NSLocalizedString("sbe.exampleText.centered", comment: "")
        view.addSubview(searchBar4)

        // TODO: SearchBar4: centered text lets the icon on the left - this is not intended!
        let leftViewNoCancelButton = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        noCancelButtonSearchbar = defaultSearchBar(withRasterSize: rasterSize, leftView: leftViewNoCancelButton, rightView: nil, delegate: self, useCancelButton: false)
        noCancelButtonSearchbar.textAlignment = .center
        noCancelButtonSearchbar.text = NSLocalizedString("sbe.exampleText.noCancelButton", comment: "")
        view.addSubview(noCancelButtonSearchbar)

        let addressTop = CNMutablePostalAddress()
        addressTop.city = "Frankfurt am Main"
        addressTop.street = "Mainzer Landstraße 123"
        addressSearchbarTop = defaultSearchBar(withRasterSize: rasterSize, leftView: nil, rightView: nil, delegate: self)
        addressSearchbarTop.text = addressFormatter.string(from: addressTop)
        addressSearchbarTop.updateBackgroundImage(withRadius: 6, corners: [.topLeft, .topRight], color: UIColor.white)
        view.addSubview(addressSearchbarTop)

        let addressBottom = CNMutablePostalAddress()
        addressBottom.city = "Frankfurt am Main"
        addressBottom.street = "Darmstädter Landstraße 123"
        addressSearchbarBottom = defaultSearchBar(withRasterSize: rasterSize, leftView: nil, rightView: nil, delegate: self)
        addressSearchbarBottom.text = addressFormatter.string(from: addressBottom)
        addressSearchbarBottom.updateBackgroundImage(withRadius: 6, corners: [.bottomLeft, .bottomRight], color: UIColor.white)
        view.addSubview(addressSearchbarBottom)

        // we need to set the title view to nil and get always the right frame
        navigationItem.titleView = nil

        // update properties of your custom title view
        navigationSearchBar = defaultSearchBar(withRasterSize: rasterSize,
                                               leftView: imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize),
                                               rightView: nil,
                                               delegate: self)

        let titleView = SearchbarTitleView(searchbar: navigationSearchBar)
        navigationItem.titleView = titleView

        setupLayoutConstraints()

        let allSearchBars: [SHSearchBar] = [searchBar1, searchBar2, searchBar3, searchBar4, addressSearchbarTop, addressSearchbarBottom]

        // Update the searchbar config

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            let raster: CGFloat = 22.0
            self?.rasterSize = raster

            for bar in allSearchBars {
                var config = bar.config
                config.cancelButtonTextAttributes = [.foregroundColor : UIColor.red]
                config.rasterSize = raster
                bar.config = config
            }
            self?.setupLayoutConstraints()
        }
    }

    func setupLayoutConstraints() {
        let searchbarHeight: CGFloat = 44.0

        // Deactivate old constraints
        viewConstraints?.forEach { $0.isActive = false }

        let constraints = [
            searchBar1.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: rasterSize),
            searchBar1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: rasterSize),
            searchBar1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -rasterSize),
            searchBar1.heightAnchor.constraint(equalToConstant: searchbarHeight),

            searchBar2.topAnchor.constraint(equalTo: searchBar1.bottomAnchor, constant: rasterSize),
            searchBar2.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: rasterSize),
            searchBar2.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -rasterSize),
            searchBar2.heightAnchor.constraint(equalToConstant: searchbarHeight),

            searchBar3.topAnchor.constraint(equalTo: searchBar2.bottomAnchor, constant: rasterSize),
            searchBar3.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: rasterSize),
            searchBar3.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -rasterSize),
            searchBar3.heightAnchor.constraint(equalToConstant: searchbarHeight),

            searchBar4.topAnchor.constraint(equalTo: searchBar3.bottomAnchor, constant: rasterSize),
            searchBar4.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: rasterSize),
            searchBar4.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -rasterSize),
            searchBar4.heightAnchor.constraint(equalToConstant: searchbarHeight),

            noCancelButtonSearchbar.topAnchor.constraint(equalTo: searchBar4.bottomAnchor, constant: rasterSize),
            noCancelButtonSearchbar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: rasterSize),
            noCancelButtonSearchbar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -rasterSize),
            noCancelButtonSearchbar.heightAnchor.constraint(equalToConstant: searchbarHeight),

            addressSearchbarTop.topAnchor.constraint(equalTo: noCancelButtonSearchbar.bottomAnchor, constant: rasterSize),
            addressSearchbarTop.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: rasterSize),
            addressSearchbarTop.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -rasterSize),
            addressSearchbarTop.heightAnchor.constraint(equalToConstant: searchbarHeight),

            addressSearchbarBottom.topAnchor.constraint(equalTo: addressSearchbarTop.bottomAnchor, constant: 1.0),
            addressSearchbarBottom.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: rasterSize),
            addressSearchbarBottom.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -rasterSize),
            addressSearchbarBottom.heightAnchor.constraint(equalToConstant: searchbarHeight)
        ]

        NSLayoutConstraint.activate(constraints)

        if viewConstraints != nil {
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }

        viewConstraints = constraints
    }
}

// MARK: - Helper Functions

func defaultSearchBar(withRasterSize rasterSize: CGFloat, leftView: UIView?, rightView: UIView?, delegate: SHSearchBarDelegate, useCancelButton: Bool = true) -> SHSearchBar {
    var config = defaultSearchBarConfig(rasterSize)
    config.leftView = leftView
    config.rightView = rightView
    config.useCancelButton = useCancelButton

    if leftView != nil {
        config.leftViewMode = .always
    }

    if rightView != nil {
        config.rightViewMode = .unlessEditing
    }

    let bar = SHSearchBar(config: config)
    bar.delegate = delegate
    bar.placeholder = NSLocalizedString("sbe.textfieldPlaceholder.default", comment: "")
    bar.updateBackgroundImage(withRadius: 6, corners: [.allCorners], color: UIColor.white)
    bar.layer.shadowColor = UIColor.black.cgColor
    bar.layer.shadowOffset = CGSize(width: 0, height: 3)
    bar.layer.shadowRadius = 5
    bar.layer.shadowOpacity = 0.25
    return bar
}

func defaultSearchBarConfig(_ rasterSize: CGFloat) -> SHSearchBarConfig {
    var config: SHSearchBarConfig = SHSearchBarConfig()
    config.rasterSize = rasterSize
//    config.cancelButtonTitle = NSLocalizedString("sbe.general.cancel", comment: "")
    config.cancelButtonTextAttributes = [.foregroundColor : UIColor.darkGray]
    config.textContentType = UITextContentType.fullStreetAddress.rawValue
    config.textAttributes = [.foregroundColor : UIColor.gray]
    return config
}

func imageViewWithIcon(_ icon: UIImage, rasterSize: CGFloat) -> UIImageView {
    let imgView = UIImageView(image: icon)
    imgView.frame = CGRect(x: 0, y: 0, width: icon.size.width + rasterSize * 2.0, height: icon.size.height)
    imgView.contentMode = .center
    imgView.tintColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1)
    return imgView
}
