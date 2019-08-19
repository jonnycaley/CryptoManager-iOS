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
    
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    private let splashPresenter = SplashPresenter(splashService: SplashService())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureUI()

        splashPresenter.setViewDelegate(splashViewDelegate: self)
        splashPresenter.onInit()
    }
    
    func configureUI() {
        view.backgroundColor = UIColor.white
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.addSubview(activityIndicator)

    }
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
//        view.addSubview(NavigationBar())
    }
    
    func toMainTabActivity() {
        let mainViewController = TabBarController()
        
        AppDelegate.shared.rootViewController.switchToTabsScreen()
        
//        let appdel = UIApplication.shared.delegate as! AppDelegate
//        appdel.window?.rootViewController = mainViewController
        
//        self.present(mainViewController, animated: false, completion: nil)
    }
    
    func loadBaseFiats(fiats: [String : Double]) {
        
    }

}
