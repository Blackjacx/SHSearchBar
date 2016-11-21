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
        
        view.backgroundColor = UIColor.whiteColor()

        searchBar1 = defaultSearchBar()
        view.addSubview(searchBar1)

        searchBar2 = defaultSearchBar()
        searchBar2.textField.text = "Example With Text"
        view.addSubview(searchBar2)

        let search3ImgView = UIImageView(image: UIImage(named: "icon-search")?.imageWithRenderingMode(.AlwaysTemplate))
        search3ImgView.contentMode = .Center
        search3ImgView.tintColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1)
        searchBar3 = defaultSearchBar()
        searchBar3.textField.text = "Example With Left View"
        searchBar3.textField.leftView = search3ImgView
        view.addSubview(searchBar3)

        let search4ImgView = UIImageView(image: UIImage(named: "icon-search")?.imageWithRenderingMode(.AlwaysTemplate))
        search4ImgView.contentMode = .Center
        search4ImgView.tintColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1)
        searchBar4 = defaultSearchBar()
        searchBar4.textField.textAlignment = .Center
        searchBar4.textField.text = "Example With Centered Text"
        searchBar4.textField.leftView = search4ImgView
        searchBar4.hidden = true // TODO: centered text lets the icon on the left - this is not intended!
        view.addSubview(searchBar4)

        addressSearchbarTop = defaultSearchBar()
        addressSearchbarTop.textField.text = "Example With Text"
        addressSearchbarTop.updateBackgroundWith(6, corners: [.TopLeft, .TopRight], color: UIColor.whiteColor())
        view.addSubview(addressSearchbarTop)

        addressSearchbarBottom = defaultSearchBar()
        addressSearchbarBottom.textField.text = "Example With Text"
        addressSearchbarBottom.updateBackgroundWith(6, corners: [.BottomLeft, .BottomRight], color: UIColor.whiteColor())
        view.addSubview(addressSearchbarBottom)

        setupViewConstraints(usingMargin: 11.0)
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
            addressSearchbarTop.bottomAnchor.constraintEqualToAnchor(addressSearchbarBottom.topAnchor, constant: -margin),
            addressSearchbarTop.heightAnchor.constraintEqualToConstant(searchbarHeight),

            addressSearchbarBottom.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: margin),
            addressSearchbarBottom.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -margin),
            addressSearchbarBottom.heightAnchor.constraintEqualToConstant(searchbarHeight),
        ]
        NSLayoutConstraint.activateConstraints(constraints)
    }

    private func defaultSearchBar() -> SHSearchBar {
        let attributes = [
            NSForegroundColorAttributeName:UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor()]
        let config: SHSearchBarConfig = SHSearchBarConfig(animationDuration: 0.25,
                                                          rasterSize: 11.0,
                                                          textAttributes: attributes,
                                                          cancelButtonTitle: "Abortar",
                                                          cancelButtonTextColor: UIColor.redColor(),
                                                          textContentType: UITextContentTypeFullStreetAddress)
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


    // MARK: - SHSearchBarDelegate

    func searchBarShouldReturn(searchBar: SHSearchBar) -> Bool {
        searchBar.textField.resignFirstResponder()
        return true
    }
}

