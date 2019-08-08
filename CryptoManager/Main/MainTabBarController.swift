//
//  MainTabBarController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 05/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, ThemeChangeProtocol {
    
//    var themeChangeDelegate: ThemeChangeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupTabBar() {
        
        let portfolioViewController = PortfolioViewController()
        portfolioViewController.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(named: "nav_home"), selectedImage: UIImage(named: "nav_home"))
        
        let marketsViewController = MarketsViewController()
        marketsViewController.tabBarItem = UITabBarItem(title: "Markets", image: UIImage(named: "nav_candlestick"), selectedImage: UIImage(named: "nav_candlestick"))
        
        let newsViewController = NewsViewController()
        newsViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "nav_newspaper"), selectedImage: UIImage(named: "nav_newspaper"))
        
        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "nav_settings"), selectedImage: UIImage(named: "nav_settings"))
        settingsViewController.themeChangeDelegate = self
        
        let tabBarList = [portfolioViewController, marketsViewController, newsViewController, settingsViewController]
        viewControllers = tabBarList
        
    }
    
    
    func onThemeChanged() {
        
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
