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
        searchBar4.hidden = true // Does not fork as intended
        view.addSubview(searchBar4)

        setupConstraints()
    }
    
    private func setupConstraints() {
        let views: [String: AnyObject] = ["TLG":topLayoutGuide, "search1":searchBar1, "search2":searchBar2, "search3":searchBar3, "search4":searchBar4]
        let metrics = ["margin":11, "searchHeight":44]
        
        let formatList: [String] = [
            // SearchBar
            "H:|-(margin)-[search1]-(margin)-|",
            "H:|-(margin)-[search2]-(margin)-|",
            "H:|-(margin)-[search3]-(margin)-|",
            "H:|-(margin)-[search4]-(margin)-|",
            "V:[TLG]-(margin)-[search1(searchHeight)]-(margin)-[search2(searchHeight)]-(margin)-[search3(searchHeight)]-(margin)-[search4(searchHeight)]"
            ]
        
        for format in formatList {
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: [], metrics: metrics, views: views))
        }
    }

    private func defaultSearchBar() -> SHSearchBar {
        let bar = SHSearchBar()
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

