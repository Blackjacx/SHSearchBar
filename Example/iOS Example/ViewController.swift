//
//  ViewController.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 08/01/2016.
//  Copyright (c) 2016 Stefan Herold. All rights reserved.
//

import UIKit
import SHSearchBar

class ViewController: UIViewController, SHSearchBarDelegate {

    var searchBar1: SHSearchBar!
    var searchBar2: SHSearchBar!
    var searchBar3: SHSearchBar!
    var searchBar4: SHSearchBar!
    var addressSearchbarTop: SHSearchBar!
    var addressSearchbarBottom: SHSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rasterSize: CGFloat = 11.0
        let searchGlassIconTemplate = UIImage(named: "icon-search")!.imageWithRenderingMode(.AlwaysTemplate)

        view.backgroundColor = UIColor.whiteColor()

        searchBar1 = defaultSearchBarWithRasterSize(rasterSize)
        searchBar1.textField.leftView = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar1.textField.leftViewMode = .Always
        view.addSubview(searchBar1)

        searchBar2 = defaultSearchBarWithRasterSize(rasterSize)
        searchBar2.textField.text = "Example With Text"
        searchBar2.textField.rightView = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar2.textField.rightViewMode = .Always
        view.addSubview(searchBar2)

        searchBar3 = defaultSearchBarWithRasterSize(rasterSize)
        searchBar3.textField.text = "Example With Left View"
        searchBar3.textField.leftView = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar3.textField.leftViewMode = .Always
        searchBar3.textField.rightView = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar3.textField.rightViewMode = .UnlessEditing
        view.addSubview(searchBar3)

        searchBar4 = defaultSearchBarWithRasterSize(rasterSize)
        searchBar4.textField.textAlignment = .Center
        searchBar4.textField.text = "Example With Centered Text"
        searchBar4.textField.leftView = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        view.addSubview(searchBar4)

        addressSearchbarTop = defaultSearchBarWithRasterSize(rasterSize)
        addressSearchbarTop.textField.text = "Mainzer Landstraße 123, Frankfurt am Main"
        addressSearchbarTop.updateBackgroundWith(6, corners: [.TopLeft, .TopRight], color: UIColor.whiteColor())
        view.addSubview(addressSearchbarTop)

        addressSearchbarBottom = defaultSearchBarWithRasterSize(rasterSize)
        addressSearchbarBottom.textField.text = "Darmstädter Landstraße 123, Frankfurt am Main"
        addressSearchbarBottom.updateBackgroundWith(6, corners: [.BottomLeft, .BottomRight], color: UIColor.whiteColor())
        view.addSubview(addressSearchbarBottom)

        setupViewConstraints(usingMargin: rasterSize)

        searchBar1.hidden = false
        searchBar2.hidden = false
        searchBar3.hidden = false
        searchBar4.hidden = true // TODO: centered text lets the icon on the left - this is not intended!
        addressSearchbarTop.hidden = false
        addressSearchbarBottom.hidden = false


        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            var config: SHSearchBarConfig = SHSearchBarConfig()
            config.rasterSize = 22.0
            config.textColor = UIColor.darkGrayColor()
            config.textContentType = UITextContentTypeFullStreetAddress
            config.cancelButtonTitle = "Cancel"
            config.cancelButtonTextColor = UIColor.darkGrayColor()
            self.searchBar1.config = config
            self.searchBar2.config = config
            self.searchBar3.config = config
            self.searchBar4.config = config
            self.addressSearchbarTop.config = config
            self.addressSearchbarBottom.config = config
        }
    }
    
    private func setupViewConstraints(usingMargin margin: CGFloat) {
        let searchbarHeight: CGFloat = 44.0
        let constraints = [
            topLayoutGuide.bottomAnchor.constraintEqualToAnchor(searchBar1.topAnchor, constant: -margin),

            searchBar1.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: margin),
            searchBar1.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -margin),
            searchBar1.bottomAnchor.constraintEqualToAnchor(searchBar2.topAnchor, constant: -margin),
            searchBar1.heightAnchor.constraintEqualToConstant(searchbarHeight),

            searchBar2.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: margin),
            searchBar2.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -margin),
            searchBar2.bottomAnchor.constraintEqualToAnchor(searchBar3.topAnchor, constant: -margin),
            searchBar2.heightAnchor.constraintEqualToConstant(searchbarHeight),

            searchBar3.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: margin),
            searchBar3.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -margin),
            searchBar3.bottomAnchor.constraintEqualToAnchor(searchBar4.topAnchor, constant: -margin),
            searchBar3.heightAnchor.constraintEqualToConstant(searchbarHeight),

            searchBar4.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: margin),
            searchBar4.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -margin),
            searchBar4.bottomAnchor.constraintEqualToAnchor(addressSearchbarTop.topAnchor, constant: -margin),
            searchBar4.heightAnchor.constraintEqualToConstant(searchbarHeight),

            addressSearchbarTop.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: margin),
            addressSearchbarTop.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -margin),
            addressSearchbarTop.bottomAnchor.constraintEqualToAnchor(addressSearchbarBottom.topAnchor, constant: -1.0),
            addressSearchbarTop.heightAnchor.constraintEqualToConstant(searchbarHeight),

            addressSearchbarBottom.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: margin),
            addressSearchbarBottom.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -margin),
            addressSearchbarBottom.heightAnchor.constraintEqualToConstant(searchbarHeight),
        ]
        NSLayoutConstraint.activateConstraints(constraints)
    }

    private func defaultSearchBarWithRasterSize(rasterSize: CGFloat) -> SHSearchBar {
        var config: SHSearchBarConfig = SHSearchBarConfig()
        config.rasterSize = rasterSize
        config.textColor = UIColor.darkGrayColor()
        config.textContentType = UITextContentTypeFullStreetAddress
        config.cancelButtonTitle = "Cancel"
        config.cancelButtonTextColor = UIColor.darkGrayColor()

        let bar = SHSearchBar(config: config)
        bar.delegate = self
        bar.textField.placeholder = "Example"
        bar.updateBackgroundWith(6, corners: [.AllCorners], color: UIColor.whiteColor())
        bar.layer.shadowColor = UIColor.blackColor().CGColor
        bar.layer.shadowOffset = CGSize(width: 0, height: 3)
        bar.layer.shadowRadius = 5
        bar.layer.shadowOpacity = 0.25
        return bar
    }

    private func imageViewWithIcon(icon: UIImage, rasterSize: CGFloat) -> UIImageView {
        let imgView = UIImageView(image: icon)
        imgView.frame = CGRect(x: 0, y: 0, width: icon.size.width + rasterSize * 2.0, height: icon.size.height)
        imgView.contentMode = .Center
        imgView.tintColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1)
        return imgView
    }

    // MARK: - SHSearchBarDelegate

    func searchBarShouldReturn(searchBar: SHSearchBar) -> Bool {
        searchBar.textField.resignFirstResponder()
        return true
    }
}

