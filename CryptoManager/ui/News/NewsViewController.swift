//
//  NewsViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 04/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, ThemeChangeProtocol {
    
    var customView: UIView!
    
    var themeChangeDelegate: ThemeChangeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        configureNavigationBar() //has to happen after configureTableView
    }
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(NavigationBar())
    }
    
    func onThemeChanged() {
        print("NewsViewController onThemeChanged")
        configureUI()
    }

}
