//
//  MainTabBarController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 05/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, ThemeChangeProtocol, NewViewControllerProtocol {
     
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureNavigationBar() doesnt work as navigationcontroller is nil here - moved to view will appear
//        setupTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTabBar()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
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
        settingsViewController.newViewDelegate = self
        
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
    
    func onNewView(destinationController: UIViewController) {
        print("Onclicker")
        
        self.navigationController!.pushViewController(SelectBaseCurrencyViewController(), animated: true)
        
//        self.show(destinationController, sender: self)
//        
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.makeKeyAndVisible()
//        window.rootViewController = UINavigationController(rootViewController: destinationController)
        
//        self.present(destinationController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(destinationController, animated: true)
    }
}
