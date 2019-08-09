//
//  Splash.swift
//  CryptoManager
//
//  Created by Jonny Caley on 06/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, SplashViewDelegate {
    
    private let splashPresenter = SplashPresenter(splashService: SplashService())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainViewController = MainTabBarController()
        self.present(mainViewController, animated: false, completion: nil)

        splashPresenter.setViewDelegate(splashViewDelegate: self)
        splashPresenter.getBaseCurrencies()
    }
    
    func showBaseCurrencies(currencies: String) {
        print(currencies)
    }

}
