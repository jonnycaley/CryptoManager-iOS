//
//  RootViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 19/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var current: UIViewController

    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        addChild(current)
        current.view.frame = view.bounds
        
//        current.view.translatesAutoresizingMaskIntoConstraints = false
//        current.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        current.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        view.addSubview(current.view)
        
        current.didMove(toParent: self)
    }
    
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
        //        view.addSubview(NavigationBar())
    }
    
    func switchToTabsScreen() {
        let mainViewController = TabBarController()
        let new = UINavigationController(rootViewController: mainViewController)
        animateFadeTransition(to: new)
        
        addChild(new)                
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)

        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()  //1
        }
    }

}
