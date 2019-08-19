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
        
        addChild(new)                    // 2
        new.view.frame = view.bounds                   // 3
        view.addSubview(new.view)                      // 4
        new.didMove(toParent: self)      // 5
        current.willMove(toParent: nil)  // 6
        current.view.removeFromSuperview()            // 7
        current.removeFromParent()       // 8
        current = new                                  // 9
        
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
//
//    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
//        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
//        current.willMove(toParent: nil)
//        addChild(new)
//        transition(from: current, to: new, duration: 0.3, options: [], animations: {
//            new.view.frame = self.view.bounds
//        }) { completed in
//            self.current.removeFromParent()
//            new.didMove(toParent: self)
//            self.current = new
//            completion?()
//        }
//    }

}
