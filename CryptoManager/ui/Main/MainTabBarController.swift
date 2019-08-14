//
//  MainTabBarController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 05/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, ThemeChangeProtocol {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    var portfolioViewController: PortfolioViewController!
    var marketsViewController: MarketsViewController!
    var newsViewController: NewsViewController!
    var settingsViewController: SettingsViewController!
    
    func setupTabBar() {
        
        portfolioViewController = PortfolioViewController()
        portfolioViewController.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(named: "nav_home"), selectedImage: UIImage(named: "nav_home"))
        
        marketsViewController = MarketsViewController()
        marketsViewController.tabBarItem = UITabBarItem(title: "Markets", image: UIImage(named: "nav_candlestick"), selectedImage: UIImage(named: "nav_candlestick"))
        
        newsViewController = NewsViewController()
        newsViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "nav_newspaper"), selectedImage: UIImage(named: "nav_newspaper"))
        
        settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "nav_settings"), selectedImage: UIImage(named: "nav_settings"))
        settingsViewController.themeChangeDelegate = self
        
        let tabBarList = [portfolioViewController, marketsViewController, newsViewController, settingsViewController]
        viewControllers = tabBarList as! [UIViewController]
        
        self.tabBar.barTintColor = Theme.current.background
        
//        onThemeChanged()
    }
    
    
    func onThemeChanged() {
        print("Theme Changed")
        if (portfolioViewController != nil) {
            portfolioViewController.onThemeChanged()
        }
        if (marketsViewController != nil) {
            marketsViewController.onThemeChanged()
        }
        if (newsViewController != nil) {
            newsViewController.onThemeChanged()
        }
        
        self.tabBar.barTintColor = Theme.current.background
    }
}
