//
//  Splash.swift
//  CryptoManager
//
//  Created by Jonny Caley on 06/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit
import SQLite

class SplashViewController: UIViewController, SplashViewDelegate {

    private let splashPresenter = SplashPresenter(splashService: SplashService())

    override func viewDidLoad() {
        super.viewDidLoad()
                
//        let mainViewController = MainTabBarController()
//        self.present(mainViewController, animated: false, completion: nil)
        
        configureNavigationBar()

        splashPresenter.setViewDelegate(splashViewDelegate: self)
        splashPresenter.onInit()
    }
    
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(NavigationBar())
    }
    
    func loadBaseFiats(fiats: [String : Double]) {
        
    }

}
