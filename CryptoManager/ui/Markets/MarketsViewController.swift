//
//  MarketsViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 04/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class MarketsViewController: UIViewController, ThemeChangeProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        addStatusHeader() //has to happen after configureTableView
    }
    
    func addStatusHeader() {
        view.addSubview(StatusBarCover())
    }
    
    func onThemeChanged() {
        configureUI()
    }
}
