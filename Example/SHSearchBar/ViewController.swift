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
        
        
        
        view.addSubview(searchBar)
        
        
    }
}

