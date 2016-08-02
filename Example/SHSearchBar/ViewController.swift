//
//  ViewController.swift
//  SHSearchBar
//
//  Created by Stefan Herold on 08/01/2016.
//  Copyright (c) 2016 Stefan Herold. All rights reserved.
//

import UIKit
import SHSearchBar

class ViewController: UIViewController {

    var searchBar: SHSearchBar = SHSearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white()
        
        searchBar.text = "Hello World!"
        searchBar.backgroundColor = UIColor.white()
        searchBar.cornerRadius = 11
        searchBar.layer.shadowColor = UIColor.black().cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        searchBar.layer.shadowRadius = 5
        searchBar.layer.shadowOpacity = 0.25
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let views = ["searchbar":searchBar]
        let metrics = ["margin":11, "buttonHeight":44]
        
        let formatList: [String] = [
            // Text field
            "H:|-(margin)-[searchbar]-(margin)-|",
            "V:|-(100)-[searchbar(44)]",
            ]
        
        for format in formatList {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: views))
        }
    }
}

