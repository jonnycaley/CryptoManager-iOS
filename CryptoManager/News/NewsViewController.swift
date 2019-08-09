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

        self.themeChangeDelegate = self
        
        configureUI()
    }
    
    func configureUI() {
        
        configureNavigationBar() //has to happen after configureTableView
        configureStatusBarColor()
    }
    
    
    func configureStatusBarColor() {
        if(UserDefaults.standard.bool(forKey: "isDarkTheme")) {
            UIApplication.shared.statusBarStyle = .lightContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
    }
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(NavigationBar())
    }
    
    func onThemeChanged() {
        print("NewsViewController onThemeChanged")
        configureUI()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
