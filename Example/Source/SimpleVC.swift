//
//  SimpleVC.swift
//  SHSearchBarExample
//
//  Created by Oleksandr Zaporozhchenko on 2/14/19.
//  Copyright © 2019 OleksandrZaporozhchenko. All rights reserved.
//

import UIKit
import SHSearchBar

final class SimpleVC: UIViewController {
    @IBOutlet var storyboardSearchbar: SHSearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        storyboardSearchbar.textField.font = UIFont.systemFont(ofSize: 13)
        storyboardSearchbar.textField.textColor = .black
    }
}
